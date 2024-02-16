<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OA.aspx.cs" Inherits="Attendance.OA1" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Module</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <link href="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.0/main.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.0/main.js"></script>

</head>
<body>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            overflow: hidden;
            padding: 0;
        }

        .container {
            width: 50%;
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

        .img {
            margin-top: -2%;
            width: 100%;
            object-fit: contain;
            z-index: -1;
            position: absolute;
        }

        .upload-container {
            border: 2px dashed #ccc;
            padding: 20px;
            border-radius: 10px;
            text-align: center;
            background-color: white;
            height: 15vh;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);
        }

            .upload-container label {
                font-size: 18px;
                margin-bottom: 10px;
            }

            .upload-container input[type="file"] {
                display: none;
            }

        .upload-btn {
            margin-top: 5%;
            transition: background-color 0.3s ease;
            padding: 5px 10px;
            background-color: #007BFF;
            color: #fff;
            border: none;
            font-family: 'Book Antiqua';
            line-height: 1.5;
            font-size: 18px;
            border-radius: 4px;
            cursor: pointer;
        }

            .upload-btn:hover {
                transform: scale(1.2);
                transition: 0.3s ease-out;
                background-color: #003771 !important;
            }

        #fileInput {
            width: 100%;
        }



        .upload-container.dragover {
            border-color: #007BFF;
        }

        .upload-success {
            background-color: #28a745 !important;
            color: white;
        }

        .upload-failure {
            background-color: #dc3545 !important;
            color: white;
        }
    </style>
    <form id="form1" runat="server">
        <asp:Image ID="Image1" CssClass="img" runat="server" ImageUrl="../images/admin.jpg" />
        <div class="container w-100">
            <h1 class="my-4">Admin Module</h1>

            <div class="tabs d-flex justify-content-center mb-4">
                <div class="tab mx-2" onclick="showTab('upload')">Upload</div>
                <div class="tab mx-2" onclick="showTab('notifications')">Notifications</div>
            </div>

            <div id="notifications" class="tab-content">
                <div class="notification mb-2">❌ For Reg No: xxxxxxx put 3-day penalty for not informing leave</div>
                <div class="notification mb-2">✖️ For Reg No: xxxxxxx put 2-day penalty for not submitting OD letter</div>
            </div>

            <div class="upload-container tab-content" id="upload">
                <label for="fileInput">
                    <span id="dropZone" class="upload-drop-zone">Drag and drop a .xlsx or .csv file here, or click to select one
                    </span>
                    <asp:FileUpload ID="fileInput" runat="server" CssClass="form-control" accept=".xlsx, .csv" />

                </label>
                <br>
                <asp:Button ID="uploadButton" CssClass="upload-btn" runat="server" Text="Upload" OnClick="uploadButton_Click" />
            </div>
        </div>
    </form>
    <script>
        function showTab(tabId) {
            const tabs = document.querySelectorAll('.tab-content');
            tabs.forEach(tab => {
                tab.style.display = 'none';
            });
            document.getElementById(tabId).style.display = 'block';
        }

        const uploadContainer = document.getElementById('upload');
        const fileInput = document.getElementById('<%= fileInput.ClientID %>');
        const uploadButton = document.getElementById('uploadButton');

        fileInput.addEventListener('change', () => {
            if (fileInput.files.length > 0 && (fileInput.files[0].name.endsWith('.xlsx') || fileInput.files[0].name.endsWith('.csv'))) {
                uploadContainer.classList.add('file-selected', 'upload-success');
            } else {
                uploadContainer.classList.remove('file-selected', 'upload-success');
            }
        });
    </script>
</body>
</html>
