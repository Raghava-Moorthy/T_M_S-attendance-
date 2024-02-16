<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Tutor.aspx.cs" Inherits="Attendance.tutorr" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Tutor Module</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link href="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.0/main.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.0/main.js"></script>

</head>
<body>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            overflow: auto;
        }

        .container {
            width: 75%;
            margin: 0% auto 0 auto;
            padding: 10px;
            background-color: rgb(255,255,255,0.5);
            backdrop-filter: blur(8px);
            border-radius: 8px;
        }

        .tabs {
            display: flex;
            justify-content: center;
            margin-bottom: 20px;
        }

        .letter {
            margin-top: 1.3%;
        }

            .letter input[type=url] {
                line-height: 2;
                border: 0.31px thin gray;
                margin-left: 15px;
                background-color: #fff !important;
            }

        .tab {
            padding: 10px 20px;
            border: 1px solid #ccc;
            margin: auto 5px;
            cursor: pointer;
            background-color: #fff;
            transition: background-color 0.3s, color 0.3s;
        }

            .tab:hover {
                background-color: #007BFF;
                color: #fff;
            }

        .tab-content {
            display: none;
            margin: 20px 3%;
        }


        .label {
            font-weight: 600;
            font-family: 'Californian FB';
            font-size: Large;
            margin: 5% 0 auto 25%;
        }

        .send-button {
            margin-top: 10px;
            padding: 5px 10px;
            background-color: #007BFF;
            color: #fff;
            border: none;
            font-family: 'Book Antiqua';
            line-height: 1.5;
            font-size: 18px;
            border-radius: 4px;
            cursor: pointer;
            margin-left: 70%;
        }

            .send-button:hover {
                transform: scale(1.2);
                transition: 0.3s ease-out;
                background-color: #003771 !important;
            }

        .notification {
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            background-color: #fff;
            transition: background-color 0.3s;
            margin-bottom: 5px;
        }

            .notification:hover {
                background-color: #f8f9fa;
            }

        h1 {
            text-align: center;
            margin-top: -0.5%;
        }

        .calendar-content {
            margin: auto 25%;
            color: #000 !important;
            width: 50%;
            place-items: center;
            outline: none;
            display: flex;
            background-clip: content-box
        }

        .fc-event-pre {
            color: white;
            font-size: 16px;
        }

        .img {
            margin-top: -15%;
            width: 100%;
            object-fit: contain;
            z-index: -1;
            overflow: hidden;
            position: fixed;
        }

        .penalty {
            width: 10%;
            padding: 1%;
            font-size: 14px;
            font-family: Arial;
        }

            .penalty.reason {
                width: 15% !important;
            }

            .penalty.lists {
                width: 30% !important;
            }



        .header-notification {
            display: flex;
            background-color: transparent;
            outline: none;
            border: none;
            align-items: center;
        }

        .notify-img {
            margin-right: 15px;
        }

        .show-button {
            margin-left: auto;
        }

        .hider {
            display: none;
            border-top: 2px solid black;
        }

        .tot_ {
            margin-left: 20%;
        }

        .sub {
            margin-left: 30%;
        }

        .reg-req {
            font-weight: 600;
            font-family: sans-serif;
        }

        .images {
            width: 100px;
            height: 100px;
            align-content: center;
            display: flex;
            z-index: 1;
            position: relative;
        }

        .card-text {
            width: 75%;
            position: fixed;
            line-break: strict;
            position: absolute;
            margin-left: 18%;
        }
    </style>
    <form id="form2" runat="server">
        <asp:Image ID="Image1" CssClass="img" runat="server" ImageUrl="../images/tutor.jpg" />
        <div class="container w-100">
            <h1 class="my-4">Tutor Module</h1>
            <div class="tabs d-flex justify-content-center mb-4">
                <div class="tab mx-2" onclick="showTab('attendance')">Attendance</div>
                <div class="tab mx-2" onclick="showTab('penalty')">Penalty Request</div>
                <div class="tab mx-2" onclick="showTab('notifications')">Notification</div>
            </div>
            <div id="attendance" class="tab-content calendar-content">
                <div class="student-dropdown tab-content">
                    <label for="student-select" class="label">
                        Select Student

    <select id="student-select" class="penalty lists">
        <option value="">-- Select a RegNo --</option>
        <option value="std1">2115001</option>
        <option value="std2">2115002</option>
    </select>
                    </label>
                </div>
                <div id="calendar"></div>
            </div>
            <div id="penalty" class="tab-content">
                <div>
                    <p for="stdReg" class="label">
                        Student RegNo 
        <select name="stdReg" class="penalty">
            <option value="">Select</option>
            <option value="1">01</option>
            <option value="2">02</option>
            <option value="3">03</option>
        </select>
                        <select name="Reason" class="penalty reason">
                            <option value="">Select Reason</option>
                            <option value="leave">Leave</option>
                            <option value="od">OD</option>
                        </select>
                    </p>
                </div>
                <input type="submit" id="Penalty-send" class="btn btn-primary send-button" value="Send Penalty" />
            </div>


            <div id="notifications" style="display: none;">
                <asp:Repeater ID="notification" runat="server">
                    <ItemTemplate>
                        <div class="card w-50 tot_ notification">
                            <div class="header-notification card-header w-100">
                                <img src="../images/notification.png" alt="notification" id="img" width="25" height="25" class="notify-img">
                                <asp:Label ID="RegNoLabel" runat="server" Text='<%# Eval("Regno") %>' Style="display: none;"></asp:Label>
                                <asp:Label ID="IDLabel" runat="server" Text='<%# Eval("ID") %>' Style="display: none;"></asp:Label>
                                <p class="reg-req card-title" id="req-ch"><%# Eval("Regno") %> Sent Leave Request</p>
                                <div class="btn btn-primary show-button" id="so" onclick="show('<%# Eval("ID") %>')">Show</div>
                            </div>
                            <div class="card-body hider" id="hider_<%# Eval("ID") %>">
                                <p class="card-text text-justify" id="message<%# Eval("ID") %>"><%# Eval("Reason") %></p>
                                <img alt="No Image Attached" src="<%# Eval("LetterUrl")%>" id="image<%# Eval("ID") %>" class="images" onmouseover="big(<%# Eval("ID") %>)" />
                                <br />
                                <asp:Button ID="Accept" runat="server" Text="Accept" OnClick="Accept_Click" CssClass="btn btn-success sub" />
                                <asp:Button ID="Reject" runat="server" Text="Reject" OnClick="Reject_Click" CssClass="btn btn-danger sub" />
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </form>
    <script>
         function showTab(tabId) {
             const tabs = document.querySelectorAll('.tab-content');
             const calan = document.querySelectorAll('.calendar-content');
             const studentDropdown = document.querySelector('.student-dropdown');
             calan.forEach(cal => {

                 cal.style.background = 'rgb(255,255,255)';
                 cal.style.color = '#000';
                 cal.style.padding = '1.6%';
             });
             tabs.forEach(tab => {
                 tab.style.display = 'none';
             });
             document.getElementById(tabId).style.display = 'block';

             if (tabId === 'attendance') {
                 studentDropdown.style.display = 'block';
             }
             else
                 studentDropdown.style.display = 'none';
             if (tabId === "notifications")
                 document.getElementById('notification').style.display = "block";
             else {
                 document.getElementById('notifications').style.display = 'none';
                 const notificationContent = document.querySelectorAll('.hider');
                 notificationContent.forEach(content => {
                     content.style.display = 'none';
                 });
             }
         }
         document.addEventListener('DOMContentLoaded', function () {
             initStudentDropdown();
         });
         function initStudentDropdown() {
             var studentSelect = document.getElementById('student-select');
             studentSelect.addEventListener('change', function () {
                 var selectedRegNo = studentSelect.value;
                 if (selectedRegNo) {
                     initFullCalendar(selectedRegNo);
                 }
             });
         }
         function initFullCalendar(selectedRegNo) {
             var calendarEl = document.getElementById('calendar');

             var attendanceData = [
                 { regNo: 'std1', date: '2023-08-01', status: 'Present' },
                 { regNo: 'std1', date: '2023-08-02', status: 'Absent' },
                 { regNo: 'std2', date: '2023-08-01', status: 'Present' },
                 { regNo: 'std2', date: '2023-08-02', status: 'OD' },
                 { regNo: 'std2', date: '2023-09-25', status: 'Present' },
                 { regNo: 'std2', date: '2023-09-26', status: 'Present' },
                 { regNo: 'std2', date: '2023-09-27', status: 'Present' },
                 { regNo: 'std2', date: '2023-09-28', status: 'Absent' },
                 { regNo: 'std2', date: '2023-09-29', status: 'Absent' },
                 { regNo: 'std2', date: '2023-09-30', status: 'Present' },
             ];

             var studentAttendance = attendanceData.filter(function (attendance) {
                 return attendance.regNo === selectedRegNo;
             });

             var events = studentAttendance.map(function (attendance) {
                 var eventColor = '#F44336';

                 if (attendance.status === 'Present') {
                     eventColor = '#4CAF50';
                 } else if (attendance.status === 'OD') {
                     eventColor = '#003771';
                 }

                 return {
                     title: attendance.status,
                     start: attendance.date,
                     backgroundColor: eventColor,
                     classNames: 'attendance-event',
                     display: 'background',
                     classNames: 'fc-event-pre',
                 };
             });

             var calendar = new FullCalendar.Calendar(calendarEl, {
                 initialView: 'dayGridMonth',
                 events: events,
                 eventRender: function (info) {
                     var dayCell = info.el.closest('.fc-daygrid-day');
                     dayCell.classList.add('custom-date-cell');
                 }
             });

             calendar.render();
             document.getElementByClass('student-dropdwn').style.display = 'block';

         }


         let enlargedImage = null;

         function big(ID) {
             if (enlargedImage) {
                 // Reset the previous enlarged image to its normal size
                 resetSize();
             }

             const x = document.getElementById('image' + ID);
             x.style.width = "600px";
             x.style.height = "600px";
             x.style.margin = "-30% 0 0 5%";
             x.style.position = "absolute";
             enlargedImage = x;
         }

         function resetSize() {
             if (enlargedImage) {
                 enlargedImage.style.width = "100px";
                 enlargedImage.style.height = "100px";
                 enlargedImage.style.position = "static";
                 enlargedImage.style.margin = "0";
                 enlargedImage = null;
             }
         }


         document.addEventListener("click", resetSize);
         function show(notificationID) {
             var x = document.getElementById('hider_' + notificationID);
             if (x.style.display === 'none') {
                 x.style.display = 'block';
             } else {
                 x.style.display = 'none';
             }
         }
         function hideAllNotifications() {
             const notifications = document.querySelectorAll('.hider');
             notifications.forEach(notification => {
                 notification.style.display = 'none';
             });
         }
         function updateNotificationMessage(notificationID, updatedMessage) {
             const messageElement = document.getElementById(`message${notificationID}`);
             if (messageElement) {
                 messageElement.innerText = updatedMessage;
             }
         }
    </script>
</body>
</html>

