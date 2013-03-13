// remap jQuery to $
//(function ($) {})(window.jQuery);


/* trigger when page is ready */
$(document).ready(function () {

    //Message Variables
    var missingStudentID = "Student ID must be numeric only.";
    var genericError = "An error has occurred trying to authenticate. Please verify the login information.";
    var requiredFieldMissing = "One or more required field(s) missing.";
    var pinMissing = "Admin PIN is missing.";
    var pinIncorrect = "Admin PIN is incorrect.";
    var invalidEmail = "Email is invalid.";
    var invalidPhone = "Phone number must be all numeric.";
    var invalidMajor = "Invalid Major";
    var profileUpdated = "Profile has been updated successfully.";

    $(document).keypress(function (e) {
        if (e.which == 13) {
            $("#signinbutton").click();
        }
    });
    // CLick action for the signinbutton
    $("#signinbutton").live('click', function (e) {
        e.preventDefault();
        var userID = $('#studentid').val();
        if ($.trim($('#studentid').val()).length > 0 && $.trim($('#studentpassword').val()).length > 0) {
            var intRegex = /[0-9 -()+]+$/;
            if (!$.trim($('#studentid').val()).match(intRegex)) {
                $('#message_box').text(missingStudentID);
                $('#message_box').fadeOut(10000, function () {
                    $('#message_box').css('display', 'block');
                    $('#message_box').text("");
                });
                return;
            }
            $.ajax({
                type: 'POST',
                url: '/cf/vaishak/updateprofile.cfm',
                data: $('#signinform').serialize(),
                success: function (data, textStatus) {
                    if (typeof $('#formarea', $(data)).val() != "undefined") {
                        $('#inputarea').replaceWith($('#formarea', $(data)));
                        $("#areaofinterest").change();
                        $('#user_session_box').html("<div id='user_greetings'>Hi " + $('#studentname').val().substr(0, $('#studentname').val().indexOf(" ")) + "!</div><input type='button' value='Logout' class='logout_button' id='logout_button'>");
                        $("#formarea").tooltip({
                            position: {
                                my: "center bottom-20",
                                at: "center top",
                                using: function (position, feedback) {
                                    $(this).css(position);
                                    $("<div>").addClass("arrow").addClass(feedback.vertical).addClass(feedback.horizontal).appendTo(this);
                                }
                            }

                        });
                    } else {
                        $('#inputarea').replaceWith($('#inputarea', $(data)));
                        $('#studentid').val(userID);
                    }
                    $('#message_box').fadeOut(10000, function () {
                        $('#message_box').css('display', 'block');
                        $('#message_box').text("");
                    });
                },
                error: function (xhr, status, e) {
                    $('#message_box').text(genericError);
                    $('#message_box').css('display', 'block');
                    $('#message_box').fadeOut(10000, function () {
                        $('#message_box').css('display', 'block');
                        $('#message_box').text("");
                    });
                }
            });
        } else {
            $('#message_box').text(requiredFieldMissing);
            $('#message_box').fadeOut(10000, function () {
                $('#message_box').css('display', 'block');
                $('#message_box').text("");
            });
            //$('#message_box').css('display', 'block');
        }
    });
    $('#signinform').submit(function () {
        $("#signinbutton").click();
    });

    // CLick action for the admin signin- Without password and using swipe
    $("#adminsigninbutton").live("click", function (e) {
        e.preventDefault();
        if ($.trim($('#studentid').val()).length > 0) {
            $.ajax({
                type: 'POST',
                // url: '/cf/vaishak/reviewprofile.cfm',
                url: '/cf/vaishak/updateprofile.cfm',
                data: $('#swipesignin').serialize(),
                success: function (data, textStatus) {
                    $('#inputarea').replaceWith($('#formarea', $(data)));
                    $("#areaofinterest").change();
                    $('#user_session_box').html("<div id='user_greetings'>Hi " + $('#studentname').val().substr(0, $('#studentname').val().indexOf(" ")) + "!</div><input type='button' value='Logout' class='logout_button' id='logout_button'>");
                },
                error: function (xhr, status, e) {
                    $('#message_box').text(genericError);
                    $('#message_box').fadeOut(10000, function () {
                        $('#message_box').css('display', 'block');
                        $('#message_box').text("");
                    });
                    //$('#message_box').css('display', 'block');
                }
            });
            //$("#signin").submit();
        } else {
            $('#message_box').text(requiredFieldMissing);
            $('#message_box').fadeOut(10000, function () {
                $('#message_box').css('display', 'block');
                $('#message_box').text("");
            });
            //$('#message_box').css('display', 'block');
        }
    });

    // CLick action for the admin signin- Without password and using swipe
    $("#adminpinbutton").click(function (e) {
        e.preventDefault();
        if ($.trim($('#adminpin').val()).length > 0) {
            $.ajax({
                type: 'POST',
                url: '/cf/vaishak/swipelogin.cfm',
                data: $('#adminsignin').serialize(),
                success: function (data, textStatus) {

                    if (typeof $('#inputarea', $(data)).val() != "undefined") {
                        $('#inputarea').replaceWith($('#inputarea', $(data)));
                        $('#studentid').focus();
                        $('#user_session_box').html("<input type='button' value='Logout' class='logout_button' id='logout_button'> <input type='button' value='Manual Signin' class='logout_button' id='manualsigninbutton'>");

                    } else {
                        $('#message_box').text(pinIncorrect);
                        $('#message_box').fadeOut(10000, function () {
                            $('#message_box').css('display', 'block');
                            $('#message_box').text("");
                        });
                    }
                    /* $('#inputarea').replaceWith($('#inputarea', $(data)));
                    $('#studentid').focus();
                    $('#user_session_box').html("<div id='logout_button'>Logout</div> ");*/
                },
                error: function (xhr, status, e) {
                    $('#message_box').text(genericError);
                    $('#message_box').fadeOut(10000, function () {
                        $('#message_box').css('display', 'block');
                        $('#message_box').text("");
                    });
                }
            });
        } else {
            $('#message_box').text(pinMissing);
            $('#message_box').fadeOut(10000, function () {
                $('#message_box').css('display', 'block');
                $('#message_box').text("");
            });
        }
    });
    $('#adminsignin').submit(function (e) {
        e.preventDefault();
        $("#adminpinbutton").click();
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
        window.open('/vaishak/swpIndex.jsp');
        return false;
    });
    //Area of interest dropdown
    $("#areaofinterest").live("change", function () {
        if ($("#areaofinterest").val() !== null && $("#areaofinterest").val().indexOf("others") >= 0) {
            $('#otherinterest').show();
        } else {
            $('#otherinterest').hide();
        }
    });
    $("#areaofinterest").live("click", function () {
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
        } else {
            var regex = /^([a-zA-Z0-9_\.\-\+])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
            if (!$.trim($('#email').val()).match(regex)) {
                alert(invalidEmail);
                return false;
            }
        }
        if ($("#areaofinterest").val() == 'others' && $.trim($('#otherinterest').val()).length <= 0) {
            alert("Please enter area of interest");
            $('#otherinterest').focus();
            return false;
        }
        if ($('#phone').val() !== "") {
            var regex2 = /^[0-9\-+]+$/;
            if (!$.trim($('#phone').val()).match(regex2) || $.trim($('#phone').val()).length < 10) {
                alert(invalidPhone);
                return false;
            }
        }
        if ($.trim($('#major').val()).length > 0) {
            var regex3 = /^\D+$/;
            if (!$.trim($('#major').val()).match(regex3)) {
                alert(invalidMajor);
                return false;
            }
        }
        if ($('#subscription').is(":checked")) {
            $('#subscription').val(1);
        } else {
            $('#subscription').val(0);
        }
        $.ajax({
            type: 'POST',
            url: '/cf/vaishak/updateprofileindb.cfm',
            data: $('#updateprofile').serialize(),
            success: function (data, textStatus) {
                if (typeof $('#formarea', $(data)).val() != "undefined") {
					$('#message_green').css('display', 'block');
                    $('#message_green').text(profileUpdated);
                    //$('#formarea').replaceWith($('#formarea', $(data)));
                    //$("#areaofinterest").change();
                } else {
                    $('#formarea').replaceWith($('#inputarea', $(data)));
                }
                $('#message_green').fadeOut(10000, function () {
                    $('#message_box').text("");
                    $('#message_box').hide();
                    $('#message_green').css('display', 'block');
                    $('#message_green').text("");
                });
            },
            error: function (xhr, status, e) {
                //alert(status, e);
                $('#message_box').text("An Error Occured");
                $('#message_box').fadeOut(10000, function () {
                    $('#message_box').css('display', 'block');
                    $('#message_box').text("");
                });
            }
        });
    });
    $('#logout_button').live('click', function () {
        window.location.href = "/cf/vaishak/logout.cfm";
    });
    $('#eventradio').live('click', function () {
		if($('#eventradio').is(":checked")){
			$('#eventname').show();
			$('#eventnameSelect').show();
			$('#ortext').show();
			$('#event_border_box').show();
			$('#adminpinbutton').val("Submit");
		}else{
			$('#eventname').slideUp();
			$('#eventnameSelect').slideUp();
			$('#ortext').slideUp();
			$('#event_border_box').slideUp();
			$('#adminpinbutton').val("Sign In");
		}
    });
	$('#startDateText').on('click',function(){
		$('#startDateText').datepicker();
	});
	$('#endDate').on('click',function(){
		$('#endDate').datepicker();
	});
	$('#startDateText').on('change',function(){
		alert("Changed");
	});
});