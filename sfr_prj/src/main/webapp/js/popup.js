function popupCenter(href,w,h){
   var xPos = (document.body.clientWidth / 2) - (w / 2); 
       xPos += window.screenLeft;  //듀얼 모니터일때....
   var yPos = (screen.availHeight / 2) - (h / 2);
   console.log(xPos);
   consol.elog(yPos);
   window.open(href,"pop_window","width="+w+",height="+h+", left="+xPos+", top="+yPos+", toolbars=no, resizable=no, scrollbars=no");
}