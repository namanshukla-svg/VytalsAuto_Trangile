pageextension 60031 "SSD Posted Manf Quality" extends "Posted Man. Q.Order List"
{
    actions
    {
        addafter("&Print")
        {
            action(SyncWMS)
            {
                Caption = 'Sync with WMS';
                Image = OutlookSyncFields;
                ApplicationArea = All;
                ToolTip = 'Executes the Sync with WMS action.';

                trigger OnAction()
                var
                    SSDQualityManagement: Codeunit "SSD Quality Management";
                begin
                    SSDQualityManagement.CreatePostedQualitySyncEntries(Rec);
                end;
            }
        }
    }
}
