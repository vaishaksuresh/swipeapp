// remap jQuery to $
(function ($) {})(window.jQuery);


/* trigger when page is ready */
$(document).ready(function () {

    $(document).tooltip({
        position: {
            my: "center bottom-20",
            at: "center top",
            using: function (position, feedback) {
                $(this).css(position);
                $("<div>").addClass("arrow").addClass(feedback.vertical).addClass(feedback.horizontal).appendTo(this);
            }
        }

    });
    // CLick action for the signinbutton
    $("#signinbutton").click(function (e) {
        e.preventDefault();
        if ($.trim($('#studentid').val()).length > 0 && $.trim($('#studentpassword').val()).length > 0) {
            $.ajax({
                type: 'POST',
                url: 'reviewprofile.cfm',
                data: $('#signin').serialize(),
                success: function (data, textStatus) {
                    $('#inputarea').replaceWith($('#formarea', $(data)));
                    $("#areaofinterest").change();
                },
                error: function (xhr, status, e) {
                    alert("An Error occurred trying to login. Please check the entered data and try again.");
                }
            });
            //$("#signin").submit();
        } else {
            alert("One or more required field(s) missing.");
        }
    });

    // CLick action for the admin signin- Without password and using swipe
    $("#adminsigninbutton").live("click", function (e) {
        e.preventDefault();
        if ($.trim($('#studentid').val()).length > 0) {
            $.ajax({
                type: 'POST',
                url: 'reviewprofile.cfm',
                data: $('#swipesignin').serialize(),
                success: function (data, textStatus) {
                    $('#inputarea').replaceWith($('#formarea', $(data)));
                    $("#areaofinterest").change();
                },
                error: function (xhr, status, e) {
                    alert("An Error occurred trying to login. Please check the entered data and try again.");
                }
            });
            //$("#signin").submit();
        } else {
            alert("One or more required field(s) missing.");
        }
    });

    // CLick action for the admin signin- Without password and using swipe
    $("#adminpinbutton").click(function (e) {
        e.preventDefault();
        if ($.trim($('#adminpin').val()).length > 0) {
            $.ajax({
                type: 'POST',
                url: 'swipelogin.cfm',
                data: $('#adminsignin').serialize(),
                success: function (data, textStatus) {
                    $('#inputarea').replaceWith($('#inputarea', $(data)));
                },
                error: function (xhr, status, e) {
                    alert("An Error occurred trying to login. Please check the entered data and try again.");
                }
            });
            //$("#adminsignin").submit();
        } else {
            alert("PIN missing or Incorrect.");
        }
    });

    // Click action for clicking the profile. Not Valid Anymore.
    $('#profilelink').click(function (e) {
        e.preventDefault();
        $.get('updateprofile.cfm', function (data) {
            $('#inputarea').replaceWith($('#formarea', $(data)));
        });
    });

    //Actions for Tabs on the handheld. Not valid Anymore
    $('#tabupdateprofile').click(function (e) {
        $.get('updateprofile.cfm', function (data) {
            $('#inputarea').replaceWith($('#formarea', $(data)));
        });
    });
    $('#tabhome').click(function (e) {
        $.get('index.cfm', function (data) {
            $('#formarea').replaceWith($('#inputarea', $(data)));
        });
    });

    //Actions for displaying spinner when ajax calls are made.
    $("#spinner").bind("ajaxSend", function () {
        $(this).show();
    }).bind("ajaxStop", function () {
        $(this).hide();
    }).bind("ajaxError", function () {
        $(this).hide();
    });

    //Click action for clicking the manual sign in button.
    $("#manualsigninbutton").live("click", function (e) {
        window.open('/cf/vaishak');
        return false;
    });
    //Area of interest dropdown
    $("#areaofinterest").live("change", function () {
        if ($("#areaofinterest").val() == 'others') {
            $('#otherinterest').show();
        } else {
            $('#otherinterest').hide();
        }
    });
    $("#areaofinterest").on("click", function () {
        $("#areaofinterest").change();
    });

    //On Click of the button to update profile
    $("#updateprofilebutton").live('click', function (e) {
        e.preventDefault();
        if ($.trim($('#studentname').val()).length <= 0) {
            alert("Name Cannot Be Blank");
            return false;
        }
        if ($.trim($('#email').val()).length <= 0) {
            alert("Email Cannot Be Blank");
            return false;
        }
        if ($("#areaofinterest").val() == 'others' && $.trim($('#otherinterest').val()).length <= 0) {
            alert("Please enter area of interest");
            $('#otherinterest').focus();
            return false;
        }
        if ($('#subscription').is(":checked")) {
            $('#subscription').val(1);
        } else {
            $('#subscription').val(0);
        }
        $.ajax({
            type: 'POST',
            url: 'updateprofileindb.cfm',
            data: $('#updateprofile').serialize(),
            success: function (data, textStatus) {
                $('#formarea').replaceWith($('#formarea', $(data)));
                $("#areaofinterest").change();
            },
            error: function (xhr, status, e) {
                alert(status, e);
            }
        });
    });
});