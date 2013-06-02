class Mailer < ActionMailer::Base

  def contato(nome, email, mensagem)
    @from = email
    @recipients = ['paulo@devconnit.com']
    @subject = 'Solicitação Orçamento'
    @body["nome"] = nome
    @body["email"] = email
    @body["mensagem"] = mensagem
  end

  def contato_orcamento(nome,email,mensagem)
    @from = 'paulo@devconnit.com'
    @recipients = email
    @subject = 'Solicitação de Orçamento realizada!'
    @body["nome"] = "Paulo Vítor dos Santos Zeferino"
    @body["email"] = "paulo@devconnit.com"
    @body["mensagem"] = mensagem
  end

  def grupo(assunto, email, mensagem, arquivo = nil)
    @from = 'no-reply@devconnit.com'
    @recipients = email
    @subject = assunto
    @body["nome"] = 'Agenda de Compromissos'
    @body["mensagem"] = mensagem
    unless arquivo.blank?
      attachment :content_type => "application/pdf", :body => File.read("#{RAILS_ROOT}/public/recursos/#{arquivo}"), :filename =>"#{arquivo}"
    end
    File.delete("#{RAILS_ROOT}/public/recursos/#{arquivo}") if arquivo.present?
  end

end

