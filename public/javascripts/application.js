// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function mostraOuEscondeElementosEmCheques() {
    if ($('busca_situacao').value == '2' ) {
        Element.show('tr_datas');
    } else {
        Element.hide('tr_datas');
    }
}

function selecionaTodasAsContas(todas) {
    $$('.selecionaveis').each(function (value, index){
        value.checked = todas;
    });
}

function desmarcar_cheque_pre()
{
    $('busca_pre_datado').checked = false;
}
function desmarcar_cheque_a_vista()
{
    $('busca_vista').checked = false;
}

function mostrar_pesquisa_por_tipo_situacao()
{
    
    if ($('busca_por_situacao').checked)
        $('situacao').show();
    else
        $('situacao').hide();    

}


function soNumeros(id){
    return $(id).value.replace(/\D/g,"")
}

function somaTodosEmCheques(total_id, mostrar) {
    var total = 0;
    $$('.selecionados').each(function(value, index) {
        value.checked = mostrar;
        if (mostrar) {
            total = total + parseFloat(value.lang);
        } else {
            total = 0.00;
        }
    });
    $(total_id).value = total;
    $(total_id).onblur();
}

function somaValorEmCheques(total_id, checkbox_id) {
    var total = $(total_id);
    var checkbox = $(checkbox_id);
    if (checkbox.checked) {
        total.value = parseFloat(total.value) + parseFloat(checkbox.lang);
    } else {
        total.value = parseFloat(total.value) - parseFloat(checkbox.lang);
    }
    $(total_id).onblur();
}

function desenha_a_tela_de_cadastrar_pessoa()
{
    if($('pessoa_fornecedor').checked)
    {
        $('banco').show();
        $('agencia').show();
        $('conta').show();
    }
    else
    {
        $('banco').hide();
        $('agencia').hide();
        $('conta').hide();
    }
    if($('pessoa_funcionario').checked)
    {
        $('matricula').show();
        $('cargo').show();
        $('ativo').show();
    }
    else
    {
        $('matricula').hide();
        $('cargo').hide();
        $('ativo').hide();
    }    
}

function verifica_se_existe_conta_contabil()
{
    if ($('pagamento_de_conta_provisao').value == '1')
    {
        $('conta_contabil_pessoa').highlight();
        $('conta_contabil_pessoa').show();
    }
    else
    {
        $('conta_contabil_pessoa').hide();
        if($('pagamento_de_conta_contabil_pessoa_id') != null)
        {
            $('pagamento_de_conta_conta_contabil_pessoa_id').value=null;
            $('pagamento_de_conta_nome_conta_contabil_pessoa').value=null;
        }
    }
}

function atualiza_cores_das_trs_de_listagem() {
    var classe = "par";
    $$('table.listagem tbody tr').each(function(value)
    {
        if (classe == 'par') {
            removeClass(value, 'par');
            addClass(value, 'impar');
            classe = 'impar';
        } else {
            removeClass(value, 'impar');
            addClass(value, 'par');
            classe = 'par';
        }
    });
}

function verifica_filtro_tipo_de_relatorio(){
    if (($('busca_opcoes').value == 'Contas a Receber') || ($('busca_opcoes').value == 'Geral do Contas a Receber')) 
    {
        $('tipo_situacao').show();   
    }
    else
    {
        $('tipo_situacao').hide();
    }       
}

function addClass(element, value) {
    if(!element.className) {
        element.className = value;
    } else {
        newClassName = element.className;
        newClassName+= " ";
        newClassName+= value;
        element.className = newClassName;
    }
}

function removeClass(element, value) {
    if(element.className) {
        newClassName = element.className;
        newClassName = newClassName.replace(value, '');
        element.className = newClassName;
    }
}

function valor_total_do_rateio()
{
    var j=0,soma=0.0,valor=0;
    $$('input.valores').each(function(value) 
    {
        
        if ((value.value).empty())
            valor= 0.0; 
        else
            valor =parseFloat(value.value) * 100; 
      
       
        soma = soma + valor;
    });
    
    if (isNaN(soma))
        soma=0.0;
    else
    {
        soma = (soma / 100.0).toFixed(2);
        $('soma_total_do_rateio').innerHTML = (formatar_dinheiro(soma.toString()));
        verifica_se_valor_do_rateio_e_igual_ao_da_parcela();
    }
}

function valor_total_das_parcelas()
{
    var soma=0,valor=0;
    $$('input.valor').each(function(value) 
    {
        if ((value.value).empty())
            valor= 0.0; 
        else
            valor =parseFloat(value.value) * 100; 
       
        soma = soma + valor;
    });
    
    if (isNaN(soma))
        soma=0.0;
    else
    {
        soma = (soma / 100.0).toFixed(2);
        $('soma_total_das_parcelas').innerHTML = (formatar_dinheiro(soma.toString()));
        verifica_se_valor_do_documento_e_igual_a_soma_das_parcelas();
    }
    
}

function verifica_se_valor_do_documento_e_igual_a_soma_das_parcelas()
{
    if($('soma_total_das_parcelas').innerHTML == $('valor_do_documento').innerHTML)
    {
        $('soma_total_das_parcelas').style.color='#00FF00';
        $('valor_do_documento').style.color='#00FF00';
    }
    else
    {
        $('soma_total_das_parcelas').style.color='#FF0000';
        $('valor_do_documento').style.color='#FF0000';
    }
    
}


function verifica_se_valor_do_rateio_e_igual_ao_da_parcela()
{
    
    if($('valor_da_parcela').innerHTML == $('soma_total_do_rateio').innerHTML)
    {
        $('valor_da_parcela').style.color='#00FF00';
        $('soma_total_do_rateio').style.color='#00FF00';
    }
    else
    {
        $('valor_da_parcela').style.color='#FF0000';
        $('soma_total_do_rateio').style.color='#FF0000';
    }
}

function recebe_id_da_localidade(text){
    return(text.id);
}

function verificaSeElementoEstaVisivel(id_elemento) {
    if (Element.visible(id_elemento) == false) {
        Element.show(id_elemento)
    }
}
function formatar_dinheiro(numero)
{
    var tamanho,posicao_ponto,subt,continha;
    //campo é o campo do form q recebe valor por outra função
    //tamanho é o tamanho do campo
    tamanho=numero.length;
    //onde é o lugar q tem o ponto
    posicao_ponto=numero.indexOf(".");
    //faz-se uma continha pra quantas casas tem depois da virgula (ou quase isso)
    continha= tamanho - posicao_ponto;
    //se onde for -1 (ou seja se naum achar o ponto .)
    //acrescento .00 pq naum tinha casas decimais
    if (posicao_ponto==-1)
    {
        subt=numero+".00";
    }
    //se tiver ponto eu conto as casas
    if (posicao_ponto>=0)
    {
        //e se na conta o resultado for 2 significa que tem 1 casa decima
        //entao so atribuo numero em sbt pois ele se encontra formatado
        if (continha==2)
            subt=numero + "0";
        else
            subt=numero;
    }
    return subt;
}

function mostra_elemento_justificativa()
{
    
    if(parseFloat($('parcela_outros_acrescimos_em_reais').value) > 0)
    {
        $('justificativa_outros').highlight();
        $('justificativa_outros').show();
    }
    else
    {
        $('justificativa_outros').hide();
    }
    
}

function valor_total()
{
    var j=0,soma=0,valor=0;
    $$('input.valores').each(function(value) 
    {
        if ((value.value).empty())
            valor= 0.0; 
        else
            valor =parseFloat(value.value) * 100; 
        soma = soma + valor;
        
    });
    $$('input.valores_desconto').each(function(value) 
    {
        if ((value.value).empty())
            valor= 0.0; 
        else
            valor =parseFloat(value.value) * (-100); 
        soma = soma + valor;
        
    });
    if (isNaN(soma))
        soma=0.0;
    else
    {
        soma += parseFloat($('valor_da_retencao').value) * (-100);
        soma = (soma / 100.0).toFixed(2);
        $('soma_total_da_parcela').innerHTML = (formatar_dinheiro(soma.toString()));
    }
}

function confirmarAlteracao()
{    
    if (confirm ("Deseja replicar este rateio para todas as parcelas?"))
    {
        $('replicar_para_todos').value=1;
    }
}

function verificaSeElementoEstaAparecendo() 
{
    
    var conta_tags=0;   
    $$('input.valor').each(function(value){
        conta_tags = conta_tags + 1; 
    });
    if(conta_tags < 1)
    {
        return true
    }
    else
    {
        return false
    }
}

function atualiza_valores_retido_liquido_e_aliquota(valor,parcela)
{  
    var indice=0,
    id_aliquota='',
    id_imposto='',
    id_valor='',
    retido=0.0,
    vetor_aliquotas = new Array(),vetor_valores = new Array(); 
    valor = valor / 100.0;
    parcela = parcela/100.0;
    
    $$('input.valor').each(function(value)
    {
        indice = value.id.split("_")[3]
        id_imposto="dados_do_imposto_"+indice.toString()+"_imposto_id";    
        id_aliquota = "dados_do_imposto_"+indice.toString()+"_aliquota";
        id_valor = value.id;
        vetor_aliquotas[indice] = parseFloat($(id_imposto).value.split("#").last());
        vetor_valores[indice] = valor * (vetor_aliquotas[indice]/100.0)
        if (isNaN(vetor_aliquotas[indice])){
            $(id_aliquota).value = 0;
            $(id_valor).value = 0;
        }
        else{
            $(id_aliquota).value = vetor_aliquotas[indice];
            $(id_valor).value = vetor_valores[indice].toFixed(2);
            retido = retido + vetor_valores[indice];
        }
    });
    
    atualiza_cabecalho(parcela);
}

function atualiza_item_de_lancamento_de_imposto(valor_doc,parcela,indice){
    var
    id_aliquota = '',
    id_imposto = '',
    id_valor = '',
    aliquota = 0.0,
    valor_calc = 0,
    valor = 0.0,
    valor_doc = valor_doc/100.0,
    
    //atualiza_os_valores_do_indice
    
    id_imposto = "dados_do_imposto_"+indice+"_imposto_id";    
    id_aliquota = "dados_do_imposto_"+indice+"_aliquota";
    id_valor = "dados_do_imposto_"+indice+"_valor_imposto";
    aliquota = parseFloat($(id_imposto).value.split("#").last());
    valor_calc = valor_doc * (aliquota/100.0);
    if (isNaN(aliquota)){
        $(id_aliquota).value = 0;
        $(id_valor).value = 0;
    }
    else{
        $(id_aliquota).value = aliquota;
        $(id_valor).value = valor_calc.toFixed(2);  
    }

    
    atualiza_cabecalho(parcela); 
  
}

function atualiza_cabecalho(parcela){
    
    var liquido = 0.0,
    indice_soma = 0,    
    retido = 0;

    $$('input.valor').each(function(value){
        indice_soma = value.id.split("_")[3]
        if (!isNaN(parseFloat($("dados_do_imposto_"+indice_soma.toString()+"_valor_imposto").value))){
            retido += parseFloat($("dados_do_imposto_"+indice_soma.toString()+"_valor_imposto").value);
        }
    });
    
    parcela = parcela/100.0;
    
    if(!retido){
        liquido = parcela;
    }
    else{
        liquido = parcela - retido;
    }
    
    if (retido > parcela){
        $('retido').setAttribute('class', 'retidovermelho')
        document.getElementById("retido").innerHTML = 'R$'+'<span>&nbsp;</span>'+ formatar_dinheiro((retido.toFixed(2)).toString())
        document.getElementById("liquido").innerHTML ='R$'+'<span>&nbsp;</span>'+ formatar_dinheiro((liquido.toFixed(2)).toString())
    }
    else{
        $('retido').setAttribute('class', 'retidopreto')
        document.getElementById("retido").innerHTML = 'R$'+'<span>&nbsp;</span>'+ formatar_dinheiro((retido.toFixed(2)).toString())
        document.getElementById("liquido").innerHTML ='R$'+'<span>&nbsp;</span>'+ formatar_dinheiro((liquido.toFixed(2)).toString())
    } 
}
 
function insere_nome_e_id_para_baixa(id,elemento)
{
     
    unidade_centro = $('unidade_centro').value.split("_");
    
    if (parseFloat(id.value) > 0)
    {
        nome = 'parcela_nome_unidade_organizacional'+'_'+elemento;
        elemento_id = 'parcela_unidade_organizacional'+'_'+elemento+'_id';
        
        nome_centro = 'parcela_nome_centro'+'_'+elemento;
        id_do_centro = 'parcela_centro'+'_'+elemento+'_id';
        if ($(nome).value.empty())
        {
            $(nome).value = unidade_centro[1];
            $(elemento_id).value=unidade_centro[0];
            $(id_do_centro).value = unidade_centro[2];
            $(nome_centro).value = unidade_centro[3];
            
            
        }
    }
             
}


    
function exibir_explicacao_para_busca(ordem,mensagem)
{
    
    if (ordem == 'exibir') {
        id_explicacao = 'explicacao_busca';
        texto_explicacao = 'explicacao_texto';
        Element.update(texto_explicacao, mensagem);
        $(id_explicacao).show();
    }
    else
    {
        $(id_explicacao).hide();

    }
}

function filtra_parcelas() {
    if ($('filtro_todas').checked) {
        $$('.listagem tbody tr.pc').each(function(element){
            Element.show(element);
        })
    } else {
        $$('.listagem tbody tr.pc').each(function(element){
            Element.hide(element);
        })
        if ($('filtro_vincendas').checked) {
            $$('.listagem tbody tr.pc.Vincenda').each(function(element){
                Element.show(element);
            })
        }
        if ($('filtro_atrasadas').checked) {
            $$('.listagem tbody tr.pc.Atrasada').each(function(element){
                Element.show(element);
            })
        }
        if ($('filtro_canceladas').checked) {
            $$('.listagem tbody tr.pc.Cancelada').each(function(element){
                Element.show(element);
            })
        }
        if ($('filtro_quitadas').checked) {
            $$('.listagem tbody tr.pc.Quitada').each(function(element){
                Element.show(element);
            })
        }
    }
    atualiza_cores_das_trs_de_listagem();
}

function desmarcar_recebimento()
{
    $('busca_periodo_recebimento').checked = false;
    if( $('busca_periodo_vencimento').checked)
        $('tr_datas').show();
    else
        $('tr_datas').hide();
}

function desmarcar_vencimento()
{
    $('busca_periodo_vencimento').checked = false;
    if( $('busca_periodo_recebimento').checked)
        $('tr_datas').show();
    else
        $('tr_datas').hide();
}

function desmarcar_recebimento_vencimento()
{
    $('busca_periodo_vencimento').checked = false;
    $('busca_periodo_recebimento').checked = false;
    if( $('busca_periodo_baixa').checked)
        $('tr_datas').show();
    else
        $('tr_datas').hide();
    
}

function seleciona_situacoes()
{
    $('tr_situacao').hide();
    if ($('busca_opcao_relatorio').value == "2")
        $('tr_situacao').show();
    else
        $('tr_situacao').hide();
}

function AplicaMascara(Mascara, elemento){
    if(!elemento) return false;
    function in_array( oque, onde ){
        for(var i = 0 ; i < onde.length; i++){
            if(oque == onde[i]){
                return true;
            }
        }
        return false;
    }
    var SpecialChars = [':', '-', '.', '(',')', '/', ',', '_'];
    var oValue = elemento.value;
    var novo_valor = '';
    for( i = 0 ; i < oValue.length; i++){
        var nowMask = Mascara.charAt(i);
        var nowLetter = oValue.charAt(i);
        if(in_array(nowMask, SpecialChars) == true && nowLetter != nowMask){
            novo_valor +=  nowMask + '' + nowLetter;
        } else {
            novo_valor += nowLetter;
        }
        var DuplicatedMasks = nowMask+''+nowMask;
        var loops = 0
        while ((novo_valor.indexOf(DuplicatedMasks) >= 0) && (loops < 100)) {
            novo_valor = novo_valor.replace(DuplicatedMasks, nowMask);
            loops++;
        }
    }
    elemento.value = novo_valor;
 
}

function preparePage() { 
    Cufon.replace("#menu",{
        fontFamily: "Chalet-LondonNineteenEighty"
    });
    Cufon.replace("h1", {
        fontFamily: "Chalet-LondonNineteenEighty"    
    });
    Cufon.replace(".button", "input.button", {
        fontFamily: "Chalet-LondonNineteenSeventy"
    });
    Cufon.now();
}


