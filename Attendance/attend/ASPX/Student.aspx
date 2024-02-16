<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Student.aspx.cs" Inherits="Attendance.Student" %>

<!DOCTYPE html>

<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Module</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <link href="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.0/main.css" rel="stylesheet" />
</head>
<body>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            overflow: auto;
            padding: 0;
        }

        textarea, input {
            outline: none !important;
        }

        .container {
            width: 75%;
            margin: 2% auto 0 auto;
            padding: 10px;
            background-color: rgb(255,255,255,0.5);
            backdrop-filter: blur(6px);
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

        .message-box {
            width: 90%;
            margin: 3% 8% auto 0;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            resize: vertical;
            position: relative;
            overflow: auto;
        }

        .label {
            font-family: 'Californian FB';
            font-weight: 600;
            font-size: Large;
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
            margin-bottom: 3px;
        }

            .notification:hover {
                background-color: #f8f9fa;
            }

        h1 {
            text-align: center;
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
            margin-top: -2%;
            width: 100%;
            object-fit: contain;
            z-index: -1;
            position: fixed;
            overflow: hidden;
        }

        h4 {
            position: absolute;
            left: 40%;
            font-family: 'Californian FB';
            top: 70%;
            outline: none;
            font-weight: 600;
            font-size: Large;
        }

            h4 input[type="date"] {
                padding: 5px;
                margin-left: 15px;
                border-radius: 5px;
            }

        .days {
            position: absolute;
            font-family: 'Californian FB';
            left: 65%;
            top: 71%;
            font-weight: 600;
            font-size: Large;
            margin-right: 2%;
        }

            .days select {
                border-radius: 3px;
            }
    </style>
    <form id="form1" runat="server">

        <asp:Image ID="Image1" CssClass="img" runat="server" ImageUrl="../images/student.jpg" />
        <div class="container w-100">
            <h1 class="my-4">Student Module</h1>

            <div class="tabs d-flex justify-content-center mb-4">
                <div class="tab mx-2" onclick="showTab('attendance')">Attendance</div>
                <div class="tab mx-2" onclick="showTab('leave')">Leave Request</div>
                <div class="tab mx-2" onclick="showTab('od')">OD Request</div>
                <div class="tab mx-2" onclick="showTab('notifications')">Notifications</div>
            </div>

            <div id="attendance" class="tab-content calendar-content">
                <div id="calendar"></div>
            </div>
            <div id="leave" class="tab-content">
                <textarea id="txtReasonForLeave" runat="server" class="message-box mb-2" cols="45" rows="2" placeholder="State your reason for leave"></textarea>
                <div class="letter w-100">
                    <label for="letter" class="label">
                        Leave letter url 👉
                        <input type="url" name="letter" runat="server" placeholder="Enter a Valid url" id="txtLeaveLetterUrl" />

                    </label>
                    <h4>Select Date
                        <input type="date" id="dateInput" runat="server" min="" />

                    </h4>
                    <label for="days" class="days">
                        Number of Days
                        <asp:DropDownList ID="days" runat="server">
                            <asp:ListItem Text="" Value=""></asp:ListItem>
                            <asp:ListItem Text="One" Value="One"></asp:ListItem>
                            <asp:ListItem Text="Two" Value="Two"></asp:ListItem>
                        </asp:DropDownList>
                    </label>
                </div>
                <asp:Button ID="Button1" CssClass="btn btn-primary send-button" runat="server" Text="Send Request" OnClick="LeaveSend_Click" />
            </div>
            <div id="od" class="tab-content">
                <textarea id="txtReasonForOd" runat="server" class="message-box mb-2" cols="45" rows="2" placeholder="State your reason for leave"></textarea>

                <div class="letter w-100">
                    <label for="od" class="label">
                        OD permission letter 👉
                        <input type="url" name="od" runat="server" placeholder="Enter a Valid url" id="txtOdLetterUrl" />
                    </label>
                </div>
                <asp:Button ID="OD" CssClass="btn btn-primary send-button" runat="server" Text="Send Request" />
            </div>

            <div id="notifications" class="tab-content">
                <asp:Panel ID="notificationsDiv" runat="server"></asp:Panel>
            </div>
        </div>
    </form>

    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.0/main.js"></script>
    <script>

        function showTab(tabId) {
            const tabs = document.querySelectorAll('.tab-content');
            const calan = document.querySelectorAll('.calendar-content');
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
                initFullCalendar();
            }
            if (tabId === 'leave') {
                showNextAvailableDate();
            }
        }

        function initFullCalendar() {
            var calendarEl = document.getElementById('calendar');

            var calendar = new FullCalendar.Calendar(calendarEl, {
                initialView: 'dayGridMonth',
                events: [
                    {
                        title: 'Present',
                        start: '2023-08-01',
                        backgroundColor: '#4CAF50',
                        display: 'background',
                        classNames: 'fc-event-pre',
                    },
                    {
                        title: 'Absent',
                        start: '2023-08-02',
                        backgroundColor: '#F44336',
                        display: 'background',
                        classNames: 'fc-event-pre',

                    },
                    {
                        title: 'OD',
                        start: '2023-08-03',
                        backgroundColor: '#003771',
                        display: 'background',
                        classNames: 'fc-event-pre',

                    }],
            });

            calendar.render();
        }

        function showNextAvailableDate() {
            const currentDate = new Date();
            const tomorrow = new Date(currentDate);
            tomorrow.setDate(currentDate.getDate() + 1);

            const dateInput = document.getElementById('dateInput');
            dateInput.min = tomorrow.toISOString().split('T')[0];
        }

    </script>
</body>
</html>
