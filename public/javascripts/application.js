var saved_cell;
var proposed_letter;
var last_cell;
var letter_added;

$(document).ready(function() {

    $("#body").click(function(event) {

        last_cell = null;

        if(saved_cell) {
            saved_cell.html('-');
            saved_cell = null;
        }
        $("#word").html("");

        $('.lettercell').css('background-color', 'transparent');
    });


    $('.lettercell').click(function(event){

        // if there's letter, disallow editing
        // !!if there was also one letter added, disallow editing too!!
        // if there's empty cell, change it to editable area and allow input of single letter
        // if there's another cell editable, restore it's original state before allowing current cell editing

        var et = $(event.target);

        if(et.html() == '-') {

            if (letter_added) {
                alert('Letter was already added!');
                return;
            }

            /* TODO: and there's a letter in at least one of 4 nearest cells
                 (copy from claiming words) */

            // this is hard because now table hasn't any dimension indicators,
            // and no linked list
            // let's do it with bruteforce now, then refactor

            et_number = et.attr('id').split('_')[1];
            alert(et_number);

            // cell_left = $('cell_'+et_number)


            if(saved_cell) {
                saved_cell.html('-');
            };

            et.html('<input id="letter_input" type="text" style="width:20px"></input>');

            $('#letter_input').keypress(function(event) {
                if((event.keyCode == 13) && $('#letter_input').val().match(/^[a-zA-Zа-яА-ЯøØåÅ]$/)) {

                    // try not to fire ajax now, but
                    // remember position (container element) of letter being added
                    // so if user can't claim a word and skips,
                    // letter isn't saved


                    et.html($('#letter_input').val());
                    saved_cell = null;

                    proposed_letter = et;
                    letter_added = true;

                    // on letter input confirmation, send ajax to server and change cell.
                    // also change local table cell back to non-editable, but with letter in it
                    // cell with letter cannot be edited one more time

                }
            });

            saved_cell = et;
        } else if (et[0].tagName=='TD') {
            if(et.css('background-color')=='red') {
                // TODO stub; refactor
            } else {

                if(last_cell==null) {
                    et.css('background-color', 'red');
                    $("#word").html($("#word").html()+et.html());

                    last_cell = et;

                } else {
                    // check nearest cells to have red

                    last_cell_number = last_cell.attr('id').split('_')[1];
                    et_number = et.attr('id').split('_')[1];
                    row_letters = $('#row_letters').html();

                    // alert(last_cell_number - et_number);
                    // alert(row_letters);

                    if(((last_cell_number - et_number)==-1 && (last_cell_number % row_letters)) // nearby letters not on the edge, new after old
                            ||((last_cell_number - et_number)==1  && (et_number % row_letters)) // nearby letters not on the edge, new before old
                            ||((last_cell_number - et_number)==-row_letters)) {

                        et.css('background-color', 'red');
                        $("#word").html($("#word").html()+et.html());
                        last_cell = et;
                    }
                }
            }
        }

        event.stopPropagation();
    });

    $('form#new_game').submit(function(){
      // not allow spaces and mixed alphabet chars in form
      // also, to not mess with ruby, we could calculate length here and pass it as hidden param

      $('#game_row_letters').val($('#game_letters').val().length);

      // TODO: disallow spaces

    });

    $('#game_letters').change(function(){
      // not allow spaces and mixed alphabet chars in form
      // also, to not mess with ruby, we could calculate length here and pass it as hidden param
    });

    $('#claim_word').click(function(){

        // if word is claimed correctly, only then save_letter() - write a letter into database via ajax;

        // TODO: make another mechanism, with voting
        // in this case, letter is saved, word is shown to others, and after they vote, all is saved to db

        if($("#word").html()=="") {
            alert('claim a word first!');
            return;
        }

        $.ajax({
            url: '/games/claimword?',
            data:   {
                word : $("#word").html()  // is not transformed!!!
            },
            success: function(data){
                if(data != "error") {
                    save_letter();
                    last_cell = null;
                }
                else {
                    alert("Incorrect word");
                }
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert("Cannot claim word");
            }
        });
    });
});

function save_letter() {
    href = location.href.split('/');

    $.ajax({
        url: '/games/letter?',
        data:   {
            game : href[href.length-1],
            letter : proposed_letter.html(),
            position: proposed_letter.attr('id').split('_')[1],
        },
        success: function(data){
            if(data!='error') {
                $("#word").html("");
            }
        },
        error: function(xhr, ajaxOptions, thrownError) {
            alert("Cannot add letter");
        }
    });
}