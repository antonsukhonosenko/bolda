$(document).ready(function() {

    var saved_cell;

    $("#body").click(function(event) {

        if(saved_cell) {
            saved_cell.html('-');
            saved_cell = null;
        }

        $('.lettercell').css('background-color', 'transparent');
    });


    $('.lettercell').click(function(event){

        // if there's letter, disallow editing
        // if there's empty cell, pchange it to editable area and allow input of single letter
        // if there's another cell editable, restore it's original state before allowing current cell editing

        var et = $(event.target)

        if(et.html() == '-') /* TODO: and there's a letter in at least one of 4 nearest cells */ {

            if(saved_cell) {
                saved_cell.html('-');
            }

            et.html('<input id="letter_input" type="text" style="width:20px"></input>');

            $('#letter_input').keypress(function(event) {
                if((event.keyCode == 13) && $('#letter_input').val().match(/^[a-zA-Zа-яА-Я]$/)) {
                    et.html($('#letter_input').val());
                    saved_cell = null;

                    // ajax isn't sending properly

                    // http://127.0.0.1:3000/games/letter?game=51&position=1&letter=f - works

                    href = location.href.split('/');

                    alert(href[href.length-1]);

                    $.ajax({
                        url: '/games/letter?',
                        data:   {
                            game : href[href.length-1],  // is not transformed!!!
                            letter : et.html(),
                            position: et.attr('id').split('_')[1],
                        },
                                // "&game=<%= params[:id] %>&letter="+et.html()+'&position='+et.attr('id').split('_')[1],
                        success: function(data){
                            alert(data);
                        },
                        error: function(xhr, ajaxOptions, thrownError) {
                           alert("Cannot add letter");
                        }
                    });

                    // on letter input confirmation, send ajax to server and change cell.
                    // also change local table cell back to non-editable, but with letter in it
                    // cell with letter cannot be edited one more time

                }
            });

            saved_cell = et;
        } else if (et[0].tagName=='TD') /* TODO: and there's a RED letter in at least one of 4 nearest cells */ {


            if(et.css('background-color')=='red') /* TODO: and there's a RED letter only in 1 nearest cell */ {
                et.css('background-color', 'transparent');
            } else {
                et.css('background-color', 'red');
            }
        }


        event.stopPropagation();
    });

});