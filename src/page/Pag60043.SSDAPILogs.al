page 60043 "SSD API Logs"
{
    ApplicationArea = All;
    Caption = 'API Logs';
    PageType = List;
    SourceTable = "SSD API Log";
    UsageCategory = Administration;
    CardPageId = "SSD API Log Card";
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.', Comment = '%';
                }
                field("User Id"; Rec."User Id")
                {
                    ToolTip = 'Specifies the value of the User Id field.', Comment = '%';
                }
                field("Log DateTime"; Rec."Log DateTime")
                {
                    ToolTip = 'Specifies the value of the Log DateTime field.', Comment = '%';
                }
                field("Log Date"; Rec."Log Date")
                {
                    ToolTip = 'Specifies the value of the Log Date field.', Comment = '%';
                }
                field("URL Requested"; Rec."URL Requested")
                {
                    ToolTip = 'Specifies the value of the URL Requested field.', Comment = '%';
                }
                field("API Method"; Rec."API Method")
                {
                    ToolTip = 'Specifies the value of the API Method field.', Comment = '%';
                }
                field("Is Successful"; Rec."Is Successful")
                {
                    ToolTip = 'Specifies the value of the Is Successful field.', Comment = '%';
                }
                field("Call Start Time"; Rec."Call Start Time")
                {
                    ToolTip = 'Specifies the value of the Call Start Time field.', Comment = '%';
                }
                field("Call End Time"; Rec."Call End Time")
                {
                    ToolTip = 'Specifies the value of the Call End Time field.', Comment = '%';
                }
                field("Response Code"; Rec."Response Code")
                {
                    ToolTip = 'Specifies the value of the Response Code field.', Comment = '%';
                }
                field("Request Text"; Rec."Request Text")
                {
                    ToolTip = 'Specifies the value of the Request Text field.', Comment = '%';
                }
                field("Response Text"; Rec."Response Text")
                {
                    ToolTip = 'Specifies the value of the Response Text field.', Comment = '%';
                }
            }
        }
    }
}
