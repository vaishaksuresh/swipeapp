// remap jQuery to $
(function($) {})(window.jQuery);


/* trigger when page is ready */
$(document).ready(function() {

    $( document ).tooltip({
      position: {
        my: "center bottom-20",
        at: "center top",
        using: function( position, feedback ) {
          $( this ).css( position );
          $( "<div>" )
            .addClass( "arrow" )
            .addClass( feedback.vertical )
            .addClass( feedback.horizontal )
            .appendTo( this );
        }
      }
    });
    
    // CLick action for the signinbutton
    $("#signinbutton").click(function(e) {
        e.preventDefault();
        if ($.trim($('#studentid').val()).length > 0 && $.trim($('#studentpassword').val()).length > 0) {
            $.ajax({
                type: 'POST',
                url: 'updateprofile.cfm',
                data: $('#signin').serialize(),
                success: function(data, textStatus) {
                    $('#inputarea').replaceWith($('#formarea', $(data)));
                },
                error: function(xhr, status, e) {
                    alert(status, e);
                }
            });
            //$("#signin").submit();
        }else{
            alert("One or more required field(s) missing.");
        }
    });

    // CLick action for the admin signin- Without password and using swipe
    $("#adminsigninbutton").click(function(e) {
        e.preventDefault();
        if ($.trim($('#studentid').val()).length > 0 ) {
            $.ajax({
                type: 'POST',
                url: 'updateprofile.cfm',
                data: $('#adminsignin').serialize(),
                success: function(data, textStatus) {
                    $('#inputarea').replaceWith($('#formarea', $(data)));
                },
                error: function(xhr, status, e) {
                    alert(status, e);
                }
            });
            //$("#signin").submit();
        }else{
            alert("One or more required field(s) missing.");
        }
    });

    // Click action for clicking the profile. Not Valid Anymore.
    $('#profilelink').click(function(e) {
        e.preventDefault();
        $.get('updateprofile.cfm', function(data) {
            $('#inputarea').replaceWith($('#formarea', $(data)));
        });
    });

    //Actions for Tabs on the handheld. Not valid Anymore
    $('#tabupdateprofile').click(function(e){
     $.get('updateprofile.cfm', function(data) {
        $('#inputarea').replaceWith($('#formarea', $(data)));
    });
 });
    $('#tabhome').click(function(e){
     $.get('index.cfm', function(data) {
        $('#formarea').replaceWith($('#inputarea', $(data)));
    });
 });

    //Actions for displaying spinner when ajax calls are made.
    $("#spinner").bind("ajaxSend", function() {
        $(this).show();
    }).bind("ajaxStop", function() {
        $(this).hide();
    }).bind("ajaxError", function() {
        $(this).hide();
    });

    //Click action for clicking the manual sign in button.
    $("#manualsigninbutton").click(function(e) {
        window.open('/cf/vaishak');
        return false;

    });


});