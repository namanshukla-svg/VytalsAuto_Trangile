page 60036 "SSD Item Warehouse Mapping"
{
    ApplicationArea = All;
    Caption = 'Item Warehouse Mapping';
    PageType = List;
    SourceTable = "SSD Item Warehouse Mapping";
    UsageCategory = None;
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the value of the Location Code field.', Comment = '%';
                }
                field("SSD Zone Preference 1"; Rec."SSD Zone Preference 1")
                {
                    ToolTip = 'Specifies the value of the Zone Preference 1 field.', Comment = '%';
                }
                field("SSD Zone Preference 1 Name"; Rec."SSD Zone Preference 1 Name")
                {
                    ToolTip = 'Specifies the value of the Zone Preference 1 Name field.', Comment = '%';
                }
                field("SSD Zone Preference 2"; Rec."SSD Zone Preference 2")
                {
                    ToolTip = 'Specifies the value of the Zone Preference 2 field.', Comment = '%';
                }
                field("SSD Zone Preference 2 Name"; Rec."SSD Zone Preference 2 Name")
                {
                    ToolTip = 'Specifies the value of the Zone Preference 2 Name field.', Comment = '%';
                }
                field("SSD Reject Zone"; Rec."SSD Reject Zone")
                {
                    ToolTip = 'Specifies the value of the Hard Quarantine Zone field.', Comment = '%';
                }
                field("SSD Reject Zone Name"; Rec."SSD Reject Zone Name")
                {
                    ToolTip = 'Specifies the value of the Hard Quarantine Zone Name field.', Comment = '%';
                }
            }
        }
    }
}
