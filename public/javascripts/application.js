$(document).ready(function() {

    var saved_cell;

    $('.lettercell').click(function(event){

        // if there's letter, disallow editing
        // if there's empty cell, pchange it to editable area and allow input of single letter
        // if there's another cell editable, restore it's original state before allowing current cell editing

        var et = $(event.target)

        if(et.html() == '•') {

            if(saved_cell) {
                saved_cell.html('•');
            }

            et.html('<input id="letter_input" type="text" style="width:20px"></input>');

            $('#letter_input').keypress(function(event) {
                if((event.keyCode == 13) && $('#letter_input').val().match(/^[a-zA-Zа-яА-Я]$/)) {
                    et.html($('#letter_input').val());
                    saved_cell = null;

                    // on letter input confirmation, send ajax to server and change cell.
                    // also change local table cell back to non-editable, but with letter in it
                    // cell with letter cannot be edited one more time

                }
            });

            saved_cell = et;
        } else if (et[0].tagName=='TD') {
            et.css('background-color', 'red');
        }
    });
});