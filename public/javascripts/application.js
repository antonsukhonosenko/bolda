$(document).ready(function() {

    var saved_cell;

    $('.lettercell').click(function(event){
        if($(event.target).html() == '•') {

            if(saved_cell) {
                saved_cell.html('•');
            }

            $(event.target).html('<input type="text" style="width:20px"></input>');
            saved_cell = $(event.target);
        }

        // if there's letter, disallow editing
        // if there's empty cell, pchange it to editable area and allow input of single letter
        // if there's another cell editable, restore it's original state before allowing current cell editing
    })

        // on letter input confirmation, send ajax to server and change cell.
        // also change local table cell back to non-editable, but with letter in it
        // cell with letter cannot be edited one more time

});