page 60010 "SSD Dock Actions"
{
    ApplicationArea = All;
    Caption = 'Dock Actions';
    PageType = List;
    SourceTable = "SSD Dock";
    UsageCategory = Lists;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

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
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field("Planned Receipts"; Rec."Planned Receipts")
                {
                    ToolTip = 'Specifies the value of the Planned Receipts field.', Comment = '%';
                }
                field("Waiting Receipts"; Rec."Waiting Receipts")
                {
                    ToolTip = 'Specifies the value of the Waiting Receipts field.', Comment = '%';
                }
                field("In-Process Receipts"; Rec."In-Process Receipts")
                {
                    ToolTip = 'Specifies the value of the In-Process Receipts field.', Comment = '%';
                }
                field("Completed Receipts"; Rec."Completed Receipts")
                {
                    ToolTip = 'Specifies the value of the Completed Receipts field.', Comment = '%';
                }
                field("Dock-Out Receipts"; Rec."Dock-Out Receipts")
                {
                    ToolTip = 'Specifies the value of the Dock-Out Receipts field.', Comment = '%';
                }
                field("Planned Shipments"; Rec."Planned Shipments")
                {
                    ToolTip = 'Specifies the value of the Planned Shipments field.', Comment = '%';
                    DrillDownPageId = "Warehouse Shipment List";
                }
                field("Waiting Shipments"; Rec."Waiting Shipments")
                {
                    ToolTip = 'Specifies the value of the Waiting Shipments field.', Comment = '%';
                }
                field("In-Process Shipments"; Rec."In-Process Shipments")
                {
                    ToolTip = 'Specifies the value of the In-Process Shipments field.', Comment = '%';
                }
                field("Completed Shipments"; Rec."Completed Shipments")
                {
                    ToolTip = 'Specifies the value of the Completed Shipments field.', Comment = '%';
                }
                field("Dock-Out Shipments"; Rec."Dock-Out Shipments")
                {
                    ToolTip = 'Specifies the value of the Dock-Out Shipments field.', Comment = '%';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            group(Plan)
            {
                Caption = 'Plan';

                action(PalletPlanning)
                {
                    ApplicationArea = All;
                    Caption = 'Plan Pallets';
                    Image = Planning;
                    ToolTip = 'Executes the Plan Pallets action.';
                    RunObject = Page "SSD Dock Planning";
                }
            }
            group(Process)
            {
                Caption = 'Process';

                action(CallPickWave)
                {
                    Caption = 'Call Pick Wave';
                    ApplicationArea = All;
                    ToolTip = 'Executes the Call Pick Wave action.';
                    Image = Process;

                    trigger OnAction()
                    var
                        SSDDockManagement: Codeunit "SSD Dock Management";
                        SSDProcessPickWave: Page "SSD Process Pick Wave";
                        TimeSlot: Code[20];
                        PickDate: Date;
                    begin
                        SSDProcessPickWave.SetDock(Rec.Code);
                        SSDProcessPickWave.SetPickDate(Today);
                        if SSDProcessPickWave.RunModal() = Action::OK then begin
                            PickDate:=SSDProcessPickWave.GetPickDate();
                            TimeSlot:=SSDProcessPickWave.GetTimeSlot();
                            SSDDockManagement.CallDockPickWave(Rec."Location Code", Rec.Code, PickDate, TimeSlot);
                        end;
                    end;
                }
            }
        }
        area(Navigation)
        {
            group(Receipt)
            {
                Caption = 'Receipt';

                action(ReceiptDockIn)
                {
                    ApplicationArea = All;
                    Caption = 'Receipt Dock-In';
                    ToolTip = 'Executes the Receipt Dock-In action.';
                    RunObject = Page "SSD Receipt Dock In";
                    Image = InwardEntry;
                    RunPageLink = "Location Code"=field("Location Code"), Code=field(Code);
                }
                action(ReceiptDockOut)
                {
                    ApplicationArea = All;
                    Caption = 'Receipt Dock-Out';
                    ToolTip = 'Executes the Receipt Dock-Out action.';
                    RunObject = Page "SSD Receipt Dock Out";
                    Image = InwardEntry;
                    RunPageLink = "Location Code"=field("Location Code"), Code=field(Code);
                }
            }
            group(Shipment)
            {
                Caption = 'Shipment';

                action(ShipmentDockIn)
                {
                    ApplicationArea = All;
                    Caption = 'Shipment Dock-In';
                    ToolTip = 'Executes the Shipment Dock-In action.';
                    RunObject = Page "SSD Shipment Dock In";
                    Image = InwardEntry;
                    RunPageLink = "Location Code"=field("Location Code"), Code=field(Code);
                }
                action(ShipmentDockOut)
                {
                    ApplicationArea = All;
                    Caption = 'Shipment Dock-Out';
                    ToolTip = 'Executes the Shipment Dock-Out action.';
                    RunObject = Page "SSD Shipment Dock Out";
                    Image = InwardEntry;
                    RunPageLink = "Location Code"=field("Location Code"), Code=field(Code);
                }
                action(LoadVehicle)
                {
                    ApplicationArea = All;
                    Caption = 'Vehicle Loading';
                    Image = UpdateXML;
                    ToolTip = 'Executes the Vehicle Loading action.';

                    trigger OnAction()
                    var
                        SSDDockManagement: Codeunit "SSD Dock Management";
                    begin
                        SSDDockManagement.FillPackageBuffer(Rec);
                        Commit();
                        Page.Run(Page::"SSD Vehicle Loading", Rec);
                    end;
                }
            }
            group(ResetData)
            {
                Caption = 'Reset Data';

                action(SetWaitingStatus)
                {
                    ApplicationArea = All;
                    Caption = 'Set Waiting Status';
                    Image = Restore;
                    ToolTip = 'Executes the Set Waiting Status action.';

                    trigger OnAction()
                    begin
                        if Rec.Status = Rec.Status::Waiting then exit;
                        Rec.Status:=Rec.Status::Waiting;
                        Rec.Modify(false);
                    end;
                }
                action(SetInProcesssStatus)
                {
                    ApplicationArea = All;
                    Caption = 'Set In-Process Status';
                    Image = Restore;
                    ToolTip = 'Executes the Set In-Process Status action.';

                    trigger OnAction()
                    begin
                        if Rec.Status = Rec.Status::"In-Process" then exit;
                        Rec.Status:=Rec.Status::"In-Process";
                        Rec.Modify(false);
                    end;
                }
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                actionref(ReceiptDockIn_Promoted; ReceiptDockin)
                {
                }
                actionref(ReceiptDockOut_Promoted; ReceiptDockOut)
                {
                }
                actionref(ShipmentDockIn_Promoted; ShipmentDockin)
                {
                }
                actionref(CallPickWave_Promoted; CallPickWave)
                {
                }
                actionref(LoadVehicle_Promoted; LoadVehicle)
                {
                }
                actionref(ShipmentDockOut_Promoted; ShipmentDockOut)
                {
                }
            }
            group(Planning)
            {
                actionref(PalletPlanning_Promoted; PalletPlanning)
                {
                }
            }
        }
    }
}
