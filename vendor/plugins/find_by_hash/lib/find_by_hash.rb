require 'date'

class Hash

  def to_conditions
    params = dup
    
    if procurar_somente_por = params[:procurar_somente_por]
      params.delete :procurar_somente_por
      procurar_somente_por = procurar_somente_por.dup
      procurar_somente_por.collect!(&:to_s)
    end
      
    output_strings = []
    output_params = []
    
    params.each do |k, v|
      
      if (procurar_somente_por.include? k.to_s rescue true) && (v != '(ALL)')
      
        if k.to_s.match %r{(.*?)_manual}
          if (v.is_a? Array)
            unless v.empty?
              output_strings << "(#{v.first})"
              values = v.dup
              values.shift
              output_params = output_params + values
            end
          elsif v != ''
            output_strings << "(#{v})"
          end
          
        elsif k.to_s.match %r{(.*?)\?}
          if ['true', 'false'].include? v
            output_strings << "(#{$1} = ?)"
            output_params << (v == 'true' ? true : false)
          end
          
        elsif k.to_s.match %r{(.*?)_(maior_que|maior_ou_igual_a|menor_que|menor_ou_igual_a)}
          unless v.blank?
            sinal = case $2
            when 'maior_que';         '>'
            when 'maior_ou_igual_a';  '>='
            when 'menor_que';         '<'
            when 'menor_ou_igual_a';  '<='
            end
            campo = $1
            if campo.to_s.match %r{(.*?)_as_date}
              output_strings << "(#{$1} #{sinal} ?)"
              output_params << v.to_date.to_s(:db)
            else
              output_strings << "(#{campo} #{sinal} ?)"
              output_params << v
            end
          end
          
        elsif k.to_s.match %r{(.*?)_(contains|like)}
          unless v.blank?
            output_strings << "(#{$1} LIKE ?)"
            output_params << "%#{v}%"
          end
          
        elsif k.to_s.match %r{(.*?)_se_existir}
          unless v.blank?
            output_strings << "(#{$1} = ?)"
            output_params << v
          end
          
        elsif k.to_s.match %r{(.*?)_as_date}
          output_strings << "(#{$1} = ?)"
          output_params << v.to_date.to_s(:db)
          
        elsif v.nil?
          output_strings << "(#{k} IS NULL)"
        
        elsif v.is_a? Array
          if v.empty?
            output_strings << "(1 = 0)"
          else
            output_strings << "(#{k} IN (#{(['?'] * v.length).join(', ')}))"
            output_params = output_params + v 
          end
        else
          output_strings << "(#{k} = ?)"
          output_params << v
        end
        
      end
    end
    
    
    [output_strings.join(' AND ')] + output_params unless output_strings.empty?
  end
  
end