page 60046 "SSD API Log Card"
{
    ApplicationArea = All;
    Caption = 'SSD API Log Card';
    PageType = Card;
    SourceTable = "SSD API Log";
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("API Method"; Rec."API Method")
                {
                    ToolTip = 'Specifies the value of the API Method field.', Comment = '%';
                }
                field("Is Successful"; Rec."Is Successful")
                {
                    ToolTip = 'Specifies the value of the Is Successful field.', Comment = '%';
                }
                field("URL Requested"; Rec."URL Requested")
                {
                    ToolTip = 'Specifies the value of the URL Requested field.', Comment = '%';
                }
                field("User Id"; Rec."User Id")
                {
                    ToolTip = 'Specifies the value of the User Id field.', Comment = '%';
                }
                field("Call Start Time"; Rec."Call Start Time")
                {
                    ToolTip = 'Specifies the value of the Call Start Time field.', Comment = '%';
                }
                field("Call End Time"; Rec."Call End Time")
                {
                    ToolTip = 'Specifies the value of the Call End Time field.', Comment = '%';
                }
                field(RequestTxt; RequestTxt)
                {
                    Caption = 'Request Text';
                    MultiLine = true;
                    ToolTip = 'Specifies the value of the Request Text field.', Comment = '%';
                }
                field(ResponseTxt; ResponseTxt)
                {
                    Caption = 'Response Text';
                    MultiLine = true;
                    ToolTip = 'Specifies the value of the Response Text field.', Comment = '%';
                }
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        RequestTxt:=Rec.GetRequestText();
        ResponseTxt:=Rec.GetResponseText();
    end;
    var RequestTxt: Text;
    ResponseTxt: Text;
}
