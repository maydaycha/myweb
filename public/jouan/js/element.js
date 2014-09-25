/*****File upload******/
function closePreview(){
    $('.image-preview').popover('hide'); 
    // Need to improve the onhover event from here
    //$('.image-preview').hover(
    //    function () {
    //       $('.image-preview').popover('show');
    //    }, 
    //     function () {
    //       $('.image-preview').popover('hide');
    //    }
    //);      
}

$(document).ready(function(){
    // Set the close button
    var closebtn = $('<button/>', {
        type:"button",
        text: 'x',
        id: 'close-preview',
        style: 'font-size: initial;',
    });
    closebtn.attr("class","close pull-right");
    closebtn.attr("onclick","closePreview();");
    // Set the popover default content
    $('.image-preview').popover({
        trigger:'manual',
        html:true,
        title: "<strong>預覽</strong>"+$(closebtn)[0].outerHTML,
        content: 'Loading...',
        placement:'bottom'
    });
    // Set the clear onclick function
    $('.image-preview-clear').click(function(){
        $('.image-preview').popover('hide');
        $('.image-preview-filename').val("");
        $('.image-preview-clear').hide();
        $('.image-preview-input input:file').val("");
        $(".image-preview-input-title").text("選擇檔案"); 
    });  
});

$(function() {
    $(".image-preview-input input:file").change(function (){
        // Create the preview image 
        var img = $('<img/>', {
            id: 'dynamic',
            width:250,
            height:230
        });      
        var file = this.files[0];
        var reader = new FileReader();
        reader.onload = function (e) {
            $(".image-preview-input-title").text("重新選擇檔案");
            $(".image-preview-clear").show();
            $(".image-preview-filename").val(file.name);            
            // Set preview image into the popover data-content
            img.attr('src', e.target.result);
            $(".image-preview").attr("data-content",$(img)[0].outerHTML).popover("show");
        }        
        reader.readAsDataURL(file);
    });  
});

/************product chooser****************/
$(function(){
    $('div.product-chooser').not('.disabled').find('div.product-chooser-item').on('click', function(){
        $(this).parent().parent().find('div.product-chooser-item').removeClass('selected');
        $(this).addClass('selected');
        $(this).find('input[type="radio"]').prop("checked", true);
        
    });
});

/******************Search Panel with filters"************************/
 $(document).ready(function(e){
                $('.search-panel .dropdown-menu').find('a').click(function(e) {
                  e.preventDefault();
                  var param = $(this).attr("href").replace("#","");
                  var concept = $(this).text();
                  $('.search-panel span#search_concept').text(concept);
                  $('.input-group #search_param').val(param);
                });
              });