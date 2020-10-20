/**
 * cs_sclect
 * @param selectLayer
 */
var cf_select = function(selectLayer){
    this.targetLayer = $(selectLayer);
};

//ch_select 시동
cf_select.prototype.ready = function(){
    this.eventBind();
};

//eventObj 등록 기능
cf_select.prototype.eventBind = function(){

    var selectBtn = this.targetLayer.find('.myValue');
    var selectLayer = this.targetLayer.find('.aList , .iList');
    var selectLayerBtns = this.targetLayer.find('.aList a , .iList label');

    //버튼 클릭 이벤트
    selectBtn.click(function(){
        var layerStatus = selectLayer.css('display');
        if(layerStatus === 'none'){
            selectLayer.show();
        }else{
            selectLayer.hide();
        }
    });
    //targetLayer over out 이벤트
    this.targetLayer.mouseleave(function(){
        selectLayer.hide();
    });

    //select obj 클릭 이벤트
    selectLayerBtns.click(function(){
        var selectText = $(this).html();
        var selectValue = $(this).attr('value');
        selectBtn.html(selectText);
        selectBtn.attr('selectValue' , selectValue);
        selectLayer.hide();
    });
};

//선택한 value를 return 해주는 기능
cf_select.prototype.returnValue = function(){
    return this.targetLayer.find('.myValue').attr('selectValue');
};