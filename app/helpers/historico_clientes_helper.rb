module HistoricoClientesHelper

  def status_for_select
    [
      ['Aberto', HistoricoCliente::ABERTO],
      ['Em Andamento', HistoricoCliente::EM_ANDAMENTO],
      ['Atendidas', HistoricoCliente::ATENDIDO],
      ['Correspondidas', HistoricoCliente::CORRESPONDIDO],
    ]
  end

end
