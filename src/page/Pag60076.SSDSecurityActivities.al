page 60076 "SSD Security Activities"
{
    ApplicationArea = All;
    Caption = 'Security Activities';
    PageType = CardPart;
    SourceTable = "SSD Automation Cue";

    layout
    {
        area(Content)
        {
            cuegroup(Enablers)
            {
                Caption = 'Enablers';

                field("Active Drivers"; Rec."Active Drivers")
                {
                    ToolTip = 'Specifies the value of the Drivers field.', Comment = '%';
                    DrillDownPageId = "SSD Drivers";
                }
                field("Active Vehicles"; Rec."Active Vehicles")
                {
                    ToolTip = 'Specifies the value of the Active Vehicles field.', Comment = '%';
                    DrillDownPageId = "SSD Vehicles";
                }
            }
            cuegroup(GateProcess)
            {
                Caption = 'Gate Process';

                field("Gate Inward"; Rec."Gate Inward")
                {
                    ToolTip = 'Specifies the value of the Gate Inward field.', Comment = '%';
                    DrillDownPageId = "Inward Gate Entry List";
                }
                field("Gate Outward"; Rec."Gate Outward")
                {
                    ToolTip = 'Specifies the value of the Gate Outward field.', Comment = '%';
                    DrillDownPageId = "Outward Gate Entry List";
                }
                field("Pending Gate-Out -Inward"; Rec."Pending Gate-Out -Inward")
                {
                    ToolTip = 'Specifies the value of the Pending Gate-Out -Inward field.', Comment = '%';
                    DrillDownPageId = "Posted Inward Gate Entry List";
                }
                field("Pending Gate-Out -Outward"; Rec."Pending Gate-Out -Outward")
                {
                    ToolTip = 'Specifies the value of the Pending Gate-Out -Outward field.', Comment = '%';
                    DrillDownPageId = "Posted Outward Gate Entry List";
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        if not Rec.Get()then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
    trigger OnAfterGetCurrRecord()
    begin
        Rec."Location Filter":=GetLocationCode();
    end;
    local procedure GetLocationCode()LocationCode: Code[10]var
        WarehouseEmployee: Record "Warehouse Employee";
    begin
        WarehouseEmployee.SetRange("User ID", UserId);
        WarehouseEmployee.SetRange(Default, true);
        if WarehouseEmployee.FindFirst()then LocationCode:=WarehouseEmployee."Location Code"
        else
            Error('Default Location for User not defined');
    end;
}
