var displayConfirm = function() {
            $('#mycontact .form-control-static', form).each(function(){
                var input = $('[name="'+$(this).attr("data-display")+'"]', form);
                if (input.is(":radio")) {
                    input = $('[name="'+$(this).attr("data-display")+'"]:checked', form);
                }
                if (input.is(":text")) {
                    $(this).html(input.val());
                }
                if (input.is("textarea")) {
                    $(this).html(input.val().replace(/  /g, "&nbsp;&nbsp;").replace(/\n/g,"<br>"));
                } else if (input.is("select")) {
                    $(this).html(input.find('option:selected').text());
                } else if (input.is(":radio") && input.is(":checked")) {
                    $(this).html(input.attr("data-title"));
                } else if ($(this).attr("data-display") == 'money') {
                    $(this).html(input.val()+' / HR');
                }
            });
        }