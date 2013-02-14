// remap jQuery to $
(function ($) {})(window.jQuery);


/* trigger when page is ready */
$(document).ready(function () {

    /*$(document).tooltip({
        position: {
            my: "center bottom-20",
            at: "center top",
            using: function (position, feedback) {
                $(this).css(position);
                $("<div>").addClass("arrow").addClass(feedback.vertical).addClass(feedback.horizontal).appendTo(this);
            }
        }

    });*/
	$(document).keypress(function(e) {
    if(e.which == 13) {
		$("#signinbutton").click();
    }
});
    // CLick action for the signinbutton
    $("#signinbutton").live('click',function (e) {
        e.preventDefault();
        if ($.trim($('#studentid').val()).length > 0 && $.trim($('#studentpassword').val()).length > 0) {
			var intRegex = /[0-9 -()+]+$/;
			if(!$.trim($('#studentid').val()).match(intRegex)){
				$('#signinpagemessages').text("Student ID needs to be numbers only");
            	$('#signinpagemessages').css('display', 'block');
				return;
			}
            $.ajax({
                type: 'POST',
                url: '/cf/vaishak/updateprofile.cfm',
                data: $('#signinform').serialize(),
                success: function (data, textStatus) {
					if(typeof $('#formarea', $(data)).val() != "undefined"){
						$('#inputarea').replaceWith($('#formarea', $(data)));
						$("#areaofinterest").change();
						$('#user_session_box').html("Hello "+$('#studentname').val()+"|      <a href='/cf/vaishak/logout.cfm'><b>Logout</b></a>");
					}else{
					$('#inputarea').replaceWith($('#inputarea', $(data)));
					}
                },
                error: function (xhr, status, e) {
                    // $('#signinpagemessages').text("An Error occurred trying to login. Please check the entered data and try again."+ xhr.responseText);
                    // $('#signinpagemessages').css('display', 'block');
                }
            });
        } else {
            $('#signinpagemessages').text("One or more required field(s) missing.");
            $('#signinpagemessages').css('display', 'block');
        }
    });
	$('#signinform').submit(function() {
		alert("Submitting");
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
					$('#user_session_box').html("Hello "+$('#studentname').val()+"|      <a href='/cf/vaishak/logout.cfm'><b>Logout</b></a>");
                },
                error: function (xhr, status, e) {
                    $('#signinpagemessages').text("An Error occurred trying to login. Please check the entered data and try again.");
                    $('#signinpagemessages').css('display', 'block');
                }
            });
            //$("#signin").submit();
        } else {
            $('#signinpagemessages').text("One or more required field(s) missing.");
            $('#signinpagemessages').css('display', 'block');
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
                    $('#inputarea').replaceWith($('#inputarea', $(data)));
                    $('#studentid').focus();
					$('#user_session_box').html("<a href='/cf/vaishak/logout.cfm'><b>Logout</b></a>");
                },
                error: function (xhr, status, e) {
                    $('#signinpagemessages').text("An Error occurred trying to login. Please check the entered data and try again.");
                    $('#signinpagemessages').css('display', 'block');
                }
            });
            //$("#adminsignin").submit();
        } else {
            $('#signinpagemessages').text("PIN is missing or incorrect");
            $('#signinpagemessages').css('display', 'block');
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
        window.open('/vaishak/FrontPage.jsp');
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
            url: '/cf/vaishak/updateprofileindb.cfm',
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
$('#reviewUpdateButton').live('click', function (e) {
    $('#formarea').load('/cf/vaishak/updateprofile.cfm #formarea');
});


});