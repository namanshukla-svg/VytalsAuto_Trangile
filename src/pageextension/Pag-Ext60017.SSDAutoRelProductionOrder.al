pageextension 60017 "SSD Auto Rel. Production Order" extends "Released Production Order"
{
    actions
    {
        addlast("F&unctions")
        {
            action(SyncWithAnzo)
            {
                Caption = 'Sync with WMS';
                Image = OutlookSyncFields;
                ApplicationArea = All;
                ToolTip = 'Executes the Sync with WMS action.';

                trigger OnAction()
                var
                    ProductionOrder: Record "Production Order";
                    SSDReservarionManagement: Codeunit "SSD Reservation Management";
                begin
                    ProductionOrder.SetRange(Status, Rec.Status);
                    ProductionOrder.SetRange("No.", Rec."No.");
                    ProductionOrder.FindFirst();
                    SSDReservarionManagement.SyncProductionOutput(ProductionOrder);
                end;
            }
        }
        addlast(Category_Process)
        {
            actionref(SyncWithAnzo_Promoted; SyncWithAnzo)
            {
            }
        }
    }
}
