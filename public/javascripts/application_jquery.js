J("a#venda_grupo").click(function () {
    J("div#vendas_por_grupo").toggle("slow");
});
J("a#vendas_categoria").click(function () {
    J("div#vendas_por_categoria").toggle("slow");
});
J("a#vendas_periodo").click(function () {
    J("div#form_vendas_periodo").toggle("slow");
});
J("a#link_auditoria").click(function () {
    J("div#auditoria").toggle("slow");
});

J("#data_inicial_picker").datepicker({
    dateFormat: 'dd/mm/yy'
});

J("#data").datepicker({
    dateFormat: 'dd/mm/yy'
});

J("#data_inicial_picker_4").datepicker({
    dateFormat: 'dd/mm/yy'
});

J("#data_final_picker_4").datepicker({
    dateFormat: 'dd/mm/yy'
});


J("#historico_data").datepicker({
    dateFormat: 'dd/mm/yy'
});

J("#historico_cliente_data").datepicker({
    dateFormat: 'dd/mm/yy'
});

J("#data_retirada").datepicker({
    dateFormat: 'dd/mm/yy'
});

J("#retirada_data_retirada").datepicker({
    dateFormat: 'dd/mm/yy'
});
J("#retirada_data_entrega").datepicker({
    dateFormat: 'dd/mm/yy'
});

J("#data_final_picker").datepicker({
    dateFormat: 'dd/mm/yy'
});
J("#compromisso_data").datepicker({
    dateFormat: 'dd/mm/yy'
});


J("#data_venda").datepicker({
    dateFormat: 'dd/mm/yy'
});

J("#data_inicial_picker_1").datepicker({
    dateFormat: 'dd/mm/yy'
});

J("#data_final_picker_1").datepicker({
    dateFormat: 'dd/mm/yy'
});

J("#data_inicial_picker_3").datepicker({
    dateFormat: 'dd/mm/yy'
});

J("#data_final_picker_4").datepicker({
    dateFormat: 'dd/mm/yy'
});

J("#data_inicial_picker_8").datepicker({
    dateFormat: 'dd/mm/yy'
});

J("#data_final_picker_9").datepicker({
    dateFormat: 'dd/mm/yy'
});


J("a#finalizar_venda").click(function () {
    J("div#form_finalizar_venda").toggle("slow");
});

J("a#link_compromissos").click(function () {
    J("div#compromissos").toggle("slow");
});

J("#accordion").accordion();

J("#accordion1").accordion();
J("#accordion3").accordion();

J("a#produtividade_link").click(function () {
    J("div#produtividade").toggle("slow");
});

J("#proposta_data_inicio").datepicker({
    dateFormat: 'dd/mm/yy'
});

J('input, textarea').keyup(function() {
    if(J(this).attr('class') != 'emails' && J(this).attr('class') != 'input_medio emails')
        this.value = this.value.toUpperCase();
});



function modal_compromisso()
{
    J("#modal_compromisso").dialog({
        width: 600,
        title: 'Novo Compromisso',
        close: function(ev,ui){J("#compromisso_hora_explicacao_busca").hide();}
    });
}

function close_modal()
{
    J('#modal_compromisso').dialog('close');
}

function grafico_barras(maximo,eixo_x,eixo_y,id_elemento)
{
    xax = {
        min:0,
        max:maximo,
        ticks:eixo_x
        };
    J.plot( J("#"+id_elemento),eixo_y,{
        xaxis:xax
    });
}

function grafico_pizza(id_elemento,dados)
{

    J.plot(J("#"+id_elemento),dados,{
        pie: {
            show: true,
            pieStrokeLineWidth: 0,
            pieStrokeColor: '#FFF',
            pieChartRadius: 130,
            centerOffsetTop:30,
            centerOffsetLeft:0,
            showLabel: true,
            labelOffsetFactor: 5/6,
            labelBackgroundOpacity: 0.55,
            labelFormatter: function(serie){
                return '<br/>'+Math.round(serie.percent)+'%';
            }
        },
        legend: {
            show: true,
            position: "ne",
            backgroundOpacity: 0
        }
    });


}

function showMailDialog(grupoId) {
    J("#modal_mail").dialog('open');
    J("#grupo_id").val(grupoId);
}
