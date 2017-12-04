<%@ Control Language="C#"%>
<link type="text/css" href="/ASP.Net/Modules/Metro/metrostyle.css" rel="stylesheet">
<script src="/ASP.Net/Modules/Metro/jquery.transit.min.js" type="text/javascript"></script>


<div class="metro-header">Welcome to College Management System</div>
<table align="center" class="metro" cellspacing="8" cellpadding="0">
    <colgroup><col /><col /><col /><col /><col width="5%" /><col /></colgroup>
    <tbody>
        <tr>
            <td colspan="2"><a id="a1" class="color3" href="/#Workplace"><img src="/ASP.Net/Modules/Metro/images/Computer-Desktop-64.png" /><label>Admission</label></a></td>
            <td><a class="color1" href="/#Directory"><img src="/ASP.Net/Modules/Metro/images/Bag-Laptop-64.png" /><label>Students</label></a></td>
            <td><a class="color2" href="/#Calendar"><img src="/ASP.Net/Modules/Metro/images/Calendar-Date-64.png" /><label>Timetable</label></a></td>
            <td class="space">&nbsp;</td>
            <td><a class="color4" href="#Incidents"><img src="/ASP.Net/Modules/Metro/images/Note-Memo-64.png" /><label>Dictionary</label></a></td>
        </tr>
        <tr>
            <td><a class="color7" href="#Documents"><img src="/ASP.Net/Modules/Metro/images/Bag-Laptop-64.png" /><label>Professor</label></a></td>
            <td colspan="2"><a class="color8" href="#Reports"><img src="/ASP.Net/Modules/Metro/images/Camera-64.png" /><label>Hostels</label></a></td>
            <td><a class="color1" href="#Charts"><img src="/ASP.Net/Modules/Metro/images/Projector-Screen-64.png" /><label>Staff</label></a></td>
            <td class="space">&nbsp;</td>
            <td><a class="color6" href="#MyProfile"><img src="/ASP.Net/Modules/Metro/images/Business-Man-64.png" /><label>User Managements</label></a></td>
        </tr>
        <tr>
            <td><a class="color4"><img src="/ASP.Net/Modules/Metro/images/Note-Memo-64.png" /><label>Attendance</label></a></td>
            <td><a class="color1"><img src="/ASP.Net/Modules/Metro/images/Note-Memo-64.png" /><label>Courses</label></a></td>
            <td><a class="color2"><img src="/ASP.Net/Modules/Metro/images/Note-Memo-64.png" /><label>Examination</label></a></td>
            <td><a class="color3"><img src="/ASP.Net/Modules/Metro/images/Note-Memo-64.png" /><label>Billing</label></a></td>
            <td class="space">&nbsp;</td>
            <td><a class="color3" href="#Settings"><img src="/ASP.Net/Modules/Metro/images/Branch-Engineering-64.png" /><label>Settings</label></a></td>
        </tr>
    </tbody>
</table>
<script type="text/javascript">
	function rotate360(a, i) {
		window.setTimeout(function() {
			a.transition({ perspective: '300px', rotateY: 0 }, 500);
		}, 50+100*i);
	}

$(function() {
	var links= $('table.metro A');
	for (var i= 0; i < links.length; i++) {
		rotate360($(links[i]), i);
	}
});
</script>