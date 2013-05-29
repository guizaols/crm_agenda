class TipoCompromisso < ActiveRecord::Base

  validates_presence_of :nome,:message=>"deve ser preenchido"

  has_many :compromissos


  def validate
    errors.add :base,"O campo referente a Visita Externa já se encontra ativado em outro registro" if self.visita_externa && ja_existe_tipo_externo?
  end


  def ja_existe_tipo_externo?
    tipo = TipoCompromisso.all(:conditions=>["visita_externa = ?",1]).first rescue nil
    
    retorno = true
    if !tipo.blank?
      if tipo.id == self.id
        return false
      else 
        return true
      end
    else
      return false
    end
    retorno
  end

end

