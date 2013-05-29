module DinheiroField

  def usar_campo_sem_acento(field_name)
    define_method "before_save_#{field_name}" do
      self.write_attribute(field_name.to_s + '_sem_acento', self.read_attribute(field_name).remover_acentos)
    end
    before_save "before_save_#{field_name}"
  end

  def verifica_se_centro_pertence_a_unidade_organizacional(centro, unidade_org)
    define_method "verifica_se_pertence_#{centro}" do
      if !send(centro).blank? && !send(unidade_org).blank?
        condicao = !send(unidade_org).centros.include?(send(centro))
      end
      errors.add centro, ("pertence a outra Unidade Organizacional.") if send(centro) && send(unidade_org) && condicao
    end
    validate "verifica_se_pertence_#{centro}"
  end

  def possui_conta_contabil_parametrizada(nome_do_campo, tipo_da_parametrizacao, mensagem_de_erro)
    define_method "validate_conta_parametrizada_#{nome_do_campo}" do
      conta = self.send("#{nome_do_campo}_parametrizada")
      errors.add :base, mensagem_de_erro if conta && self.send(nome_do_campo) && (self.send(nome_do_campo) != conta)
    end

    define_method "#{nome_do_campo}_parametrizada" do |*args|
      ano = args[0] || self.ano
      unidade_id = args[1] || self.unidade_id
      conta = ParametroContaValor.find_by_tipo_and_ano_and_unidade_id(tipo_da_parametrizacao, ano, unidade_id)
      conta.conta_contabil_id if conta
    end
    
    validate "validate_conta_parametrizada_#{nome_do_campo}"
  end

  def valida_anos_centro_e_unidade_organizacional(*field_names)
    field_names.each do |field_name|
      define_method "valida_ano_#{field_name}" do
        if !send(field_name).blank? && !send(field_name).entidade.blank?
          condicao = self.ano != send(field_name).ano || self.unidade.entidade != send(field_name).entidade
        end
        errors.add field_name, ("tem ano inválido.") if !self.ano.blank? && condicao
      end
      validate "valida_ano_#{field_name}"
    end
  end

  def dinheiro_field(*field_names)
    field_names.each do |field_name|
    
      define_method field_name.to_s + "_before_type_cast" do
        value = read_attribute(field_name)
        value.real.to_s
      end
      
      define_method field_name.to_s do
        value = read_attribute(field_name)
        value.real.to_f unless value.nil?
      end
      
      define_method field_name.to_s.+("=") do |param|
        if param.blank? 
          value = nil
        elsif param.is_a? Dinheiro
          value = param.to_f
        else
          begin
            value = Dinheiro.new(param).valor_decimal
          rescue
          end
        end
        write_attribute(field_name, value)
      end
      
    end
  end
  
  def converte_para_data_para_formato_date(*campos)
    campos.each do |campo|
      define_method campo.to_s do
        read_attribute(campo).to_date.to_s_br if read_attribute(campo)
      end
    end
  end 
  
  def easy_verbose(campos, options = {})
    campos.each do |chave, conteudo|
      validates_inclusion_of chave, {:in => conteudo.collect(&:last)}.merge(options)
      define_method chave.to_s + "_verbose" do
        conteudo.detect{|n| n.last == read_attribute(chave)}.first
      end
      Class.send :define_method, :retorna_para_select do
        conteudo
      end
    end
  end

  def cria_readers_e_writers_para_o_nome_dos_atributos(*campos)
    campos.each do |campo|
      define_method "nome_#{campo}" do
        self.send(campo).try :resumo
      end
    end

    attr_writer(*campos.collect{|campo| "nome_#{campo}"})
    
    define_method "zerar_campos_em_branco_#{campos.join '_'}" do
      campos.each do |campo|
        self.send("#{campo}=", nil) if instance_variable_get("@nome_#{campo}") == ''
      end
    end
    before_validation "zerar_campos_em_branco_#{campos.join '_'}"
  end

  def cria_atributos_virtuais_para_auto_complete(*campos)
    campos.each do |campo|
      attr_writer "nome_"+campo.to_s
      
      define_method "nome_"+campo.to_s do
        send(campo).try :resumo
      end
    end
  end
  
  def cria_readers_para_valores_em_dinheiro(*campos)
    campos.each do |campo|
      attr_writer campo.to_s+"_em_reais"
      define_method campo.to_s+"_em_reais" do
        send(campo) / 100.0 unless send(campo).blank?
      end
    end
  end

  def cria_readers_e_writers_para_valores_em_dinheiro(*campos)
    cria_readers_para_valores_em_dinheiro(*campos)
    define_method "before_validation_#{campos.collect(&:to_s).join '__'}" do
      campos.each do |campo|
        _valor_em_reais = instance_variable_get("@#{campo}_em_reais")
        self.send("#{campo}=", (format("%.2f", _valor_em_reais).to_f * 100 rescue nil)) unless _valor_em_reais.blank?
      end
    end
    before_validation "before_validation_#{campos.collect(&:to_s).join '__'}"
  end
  
  def data_br_field(*field_names)
    field_names.each do |field_name|
      define_method field_name.to_s do
        begin
          read_attribute(field_name).to_s_br 
        rescue
        end
      end
      
      define_method field_name.to_s + '_br?' do
        true
      end
      
      define_method(field_name.to_s + "_before_type_cast") { send field_name }
      
      define_method field_name.to_s.+("=") do |date_param|
        date_param += "/#{Time.now.year}" if date_param =~ %r{^\d+\/\d+$}
        if (date_param.is_a? String ) && (date_param.match %r{^(\d{1,2}/\d{1,2})/(\d{2})$}) 
          date_param = $1
          date_param += "/20#{$2}" if $2.to_i <= 30 
          date_param += "/19#{$2}" if $2.to_i > 30
        end
        write_attribute(field_name, (Date.valid?(date_param) ? date_param.to_date : nil))
      end
    end
    
  end
  
end