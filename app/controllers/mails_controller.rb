class MailsController < ApplicationController
  def index
    @grupos = Grupo.all
  end

  def mail_group
    grupo = Grupo.find params[:grupo_id]
    assunto = params[:assunto]
    texto = params[:texto]
    params[:arquivo] ||= []
    filename = nil
    if params[:arquivo].length > 0
      f = File.new("#{Rails.root}/public/recursos/#{params[:arquivo].original_filename}", "w+")
      f.write params[:arquivo].read
      f.close
    end
    (Pessoa.all(:conditions=>["grupo_id = ? and entidade_id = ?",grupo.id,current_usuario.id])).each do |pessoa|
        Mailer.deliver_grupo(assunto, pessoa.email.join(","), texto,params[:arquivo].original_filename)
    end
    flash[:notice] = 'Email enviado com sucesso!'
    redirect_to mails_path
  end
  
end