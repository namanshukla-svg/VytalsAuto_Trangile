table 60015 "SSD API Log"
{
    Caption = 'SSD API Log';
    DataClassification = CustomerContent;
    DrillDownPageId = "SSD API Logs";
    LookupPageId = "SSD API Logs";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
            Editable = false;
        }
        field(10; "URL Requested"; Text[1000])
        {
            Caption = 'URL Requested';
        }
        field(15; "API Method";Enum "Http Method")
        {
            Caption = 'API Method';
        }
        field(20; "User Id"; Code[50])
        {
            Caption = 'User Id';
            Editable = false;
        }
        field(25; "Log DateTime"; DateTime)
        {
            Caption = 'Log DateTime';
            Editable = false;
        }
        field(30; "Log Date"; Date)
        {
            Caption = 'Log Date';
            Editable = false;
        }
        field(35; "Is Successful"; Boolean)
        {
            Caption = 'Is Successful';
            Editable = false;
        }
        field(40; "Response Code"; Integer)
        {
            Caption = 'Response Code';
            Editable = false;
        }
        field(80; "API Request"; Blob)
        {
            Caption = 'API Request';
        }
        field(81; "Request Text"; Text[250])
        {
            Caption = 'Request Text';
        }
        field(90; "API Response"; Blob)
        {
            Caption = 'API Response';
        }
        field(91; "Response Text"; Text[250])
        {
            Caption = 'Response Text';
        }
        field(100; "Call Start Time"; Time)
        {
            Caption = 'Call Start Time';
        }
        field(110; "Call End Time"; Time)
        {
            Caption = 'Call End Time';
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
    procedure InsertAPILog(InURL: Text; APIMethod: Enum "Http Method"; APISuccessful: Boolean; ResponseCode: Integer; RequestTxt: Text; ResponseTxt: Text; StartTime: Time; EndTime: Time)
    begin
        Init();
        "URL Requested":=CopyStr(InURL, 1, 1000);
        "API Method":=APIMethod;
        "User Id":=CopyStr(UserId, 1, 50);
        "Log DateTime":=CurrentDateTime;
        "Log Date":=Today;
        "Is Successful":=APISuccessful;
        "Response Code":=ResponseCode;
        "Request Text":=CopyStr(RequestTxt, 1, 250);
        "Response Text":=CopyStr(ResponseTxt, 1, 250);
        "Call Start Time":=StartTime;
        "Call End Time":=EndTime;
        Insert();
        SetRequestText(RequestTxt);
        SetResponseText(ResponseTxt);
    end;
    procedure SetRequestText(RequestTxt: Text)
    var
        HttpOutstream: OutStream;
    begin
        Clear("API Request");
        "API Request".CreateOutStream(HttpOutstream, TEXTENCODING::UTF8);
        HttpOutstream.WriteText(RequestTxt);
        Modify();
    end;
    procedure SetResponseText(ResponseTxt: Text)
    var
        HttpOutstream: OutStream;
    begin
        Clear("API Response");
        "API Response".CreateOutStream(HttpOutstream, TEXTENCODING::UTF8);
        HttpOutstream.WriteText(ResponseTxt);
        Modify();
    end;
    procedure GetRequestText()RequestTxt: Text var
        Instream: InStream;
    begin
        RequestTxt:='';
        CalcFields("API Request");
        "API Request".CreateInStream(Instream);
        Instream.ReadText(RequestTxt);
    end;
    procedure GetResponseText()ResponseTxt: Text var
        Instream: InStream;
    begin
        ResponseTxt:='';
        CalcFields("API Response");
        "API Response".CreateInStream(Instream);
        Instream.ReadText(ResponseTxt);
    end;
}
