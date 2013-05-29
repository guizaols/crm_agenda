module MailsHelper
  def mail_dialog
    javascript_tag do "
      J('#modal_mail').dialog({
          autoOpen: false,
          width: 600,
          title: 'Enviar E-mails'
        });"
    end
  end
end
