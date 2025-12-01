page 60079 "SSD Dock Activities"
{
    ApplicationArea = All;
    Caption = 'Dock Activities';
    PageType = CardPart;
    SourceTable = "SSD Automation Cue";

    layout
    {
        area(Content)
        {
            cuegroup(Docks)
            {
                Caption = 'Docks';

                field("Dock Actions"; Rec."Dock Actions")
                {
                    DrillDownPageId = "SSD Dock Actions";
                    ToolTip = 'Specifies the value of the Docks field.', Comment = '%';
                }
                field("Dock Lines"; Rec."Dock Lines")
                {
                    ToolTip = 'Specifies the value of the Dock Lines field.', Comment = '%';
                    DrillDownPageId = "SSD Dock Lines";
                }
            }
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
            cuegroup(Planning)
            {
                Caption = 'Planning';

                field("Planned Warehouse Receipts"; Rec."Planned Warehouse Receipts")
                {
                    ToolTip = 'Specifies the value of the Planned Warehouse Receipts field.', Comment = '%';
                    DrillDownPageId = "Warehouse Receipts";
                }
                field("Planned Warehouse Shipments"; Rec."Planned Warehouse Shipments")
                {
                    ToolTip = 'Specifies the value of the Planned Warehouse Shipments field.', Comment = '%';
                    DrillDownPageId = "Warehouse Shipment List";
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
