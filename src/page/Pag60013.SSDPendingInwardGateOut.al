page 60013 "SSD Pending Inward Gate-Out"
{
    ApplicationArea = All;
    Caption = 'Pending Inward Gate-Out';
    PageType = List;
    SourceTable = "Posted Gate Entry Header";
    SourceTableView = sorting("Entry Type", "No.")order(ascending)where("Entry Type"=filter(Inward), "SSD Vehicle Status"=filter("Gate-In"));
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Gate Entry No."; Rec."Gate Entry No.")
                {
                    ToolTip = 'Specifies the posted gate entry number.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the creation date of the posted document.';
                }
                field("Posting Time"; Rec."Posting Time")
                {
                    ToolTip = 'Specifies the creation time of the posted document.';
                }
                field("SSD Vehicle No."; Rec."SSD Vehicle No.")
                {
                    ToolTip = 'Specifies the value of the Vehicle No. field.', Comment = '%';
                }
                field("SSD Driver Code"; Rec."SSD Driver Code")
                {
                    ToolTip = 'Specifies the value of the Driver Code field.', Comment = '%';
                }
                field("SSD Driver Name"; Rec."SSD Driver Name")
                {
                    ToolTip = 'Specifies the value of the Driver Name field.', Comment = '%';
                }
                field("SSD Dock No."; Rec."SSD Dock No.")
                {
                    ToolTip = 'Specifies the value of the Dock No. field.', Comment = '%';
                }
                field("SSD Material Type"; Rec."SSD Material Type")
                {
                    ToolTip = 'Specifies the value of the Material Type field.', Comment = '%';
                }
                field("SSD Planning No."; Rec."SSD Planning No.")
                {
                    ToolTip = 'Specifies the value of the Planning No. field.', Comment = '%';
                }
                field("SSD Time Slot No."; Rec."SSD Time Slot No.")
                {
                    ToolTip = 'Specifies the value of the Time Slot No. field.', Comment = '%';
                }
                field("SSD Time Slot Starting Time"; Rec."SSD Time Slot Starting Time")
                {
                    ToolTip = 'Specifies the value of the Time Slot Starting Time field.', Comment = '%';
                }
                field("SSD Time Slot Ending Time"; Rec."SSD Time Slot Ending Time")
                {
                    ToolTip = 'Specifies the value of the Time Slot Ending Time field.', Comment = '%';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the location code of the posted document.';
                }
                field("LR/RR No."; Rec."LR/RR No.")
                {
                    ToolTip = 'Specifies the lorry receipt number of the posted document.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the description of the posted document.';
                }
            }
        }
    }
}
