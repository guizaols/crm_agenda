class Mailer < ActionMailer::Base

  def contato(nome, email, mensagem)
    @from = email
    @recipients = ['paulo@inovare.net','isabela@inovare.net']
    @subject = 'Solicitação Orçamento'
    @body["nome"] = nome
    @body["email"] = email
    @body["mensagem"] = mensagem
  end

  def contato_orcamento(nome,email,mensagem)
    @from = 'paulo@inovare.net'
    @recipients = email
    @subject = 'Solicitação de Orçamento realizada!'
    @body["nome"] = "Paulo Vítor dos Santos Zeferino"
    @body["email"] = "paulo@inovare.net"
    @body["mensagem"] = mensagem
  end

  def grupo(assunto, email, mensagem,arquivo = nil)
    @from = 'no-reply@inovare.net'
    @recipients = email
    @subject = assunto
    @body["nome"] = "Inovare"
    @body["mensagem"] = mensagem
    unless arquivo.blank?
      attachment :content_type => "application/pdf",:body =>File.read("#{RAILS_ROOT}/public/recursos/#{arquivo}"),:filename =>"#{arquivo}"
    end
     File.delete "#{RAILS_ROOT}/public/recursos/#{arquivo}"
    end

end

