page 60003 "SSD Drivers"
{
    ApplicationArea = All;
    Caption = 'Drivers';
    PageType = List;
    SourceTable = "SSD Driver";
    CardPageId = "SSD Driver";
    UsageCategory = Lists;
    Editable = false;

    //InsertAllowed = false;
    //ModifyAllowed = false;
    //DeleteAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code field.', Comment = '%';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field.', Comment = '%';
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Address field.', Comment = '%';
                }
                field("Aadhar No."; Rec."Aadhar No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Aadhar No. field.', Comment = '%';
                }
                field("License Type"; Rec."License Type")
                {
                    ToolTip = 'Specifies the value of the License Type field.', Comment = '%';
                }
                field("License No."; Rec."License No.")
                {
                    ToolTip = 'Specifies the value of the License No. field.', Comment = '%';
                }
                field("Driver Experience"; Rec."Driver Experience")
                {
                    ToolTip = 'Specifies the value of the Driver Experience field.', Comment = '%';
                }
                field("Driver Company Name"; Rec."Driver Company Name")
                {
                    ToolTip = 'Specifies the value of the Driver Company Name field.', Comment = '%';
                }
            }
        }
    }
}
