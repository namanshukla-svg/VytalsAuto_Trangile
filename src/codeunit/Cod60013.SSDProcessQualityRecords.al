codeunit 60013 "SSD Process Quality Records"
{
    TableNo = "SSD WMS Sync Status";

    trigger OnRun()
    var
        SSDWMSSyncStatus: Record "SSD WMS Sync Status";
        RecordPosted: Boolean;
    begin
        RecordPosted:=SSDQualityManagement.SyncQualityStatus(Rec."Location Code", Rec."Package No.", Rec.Status);
        if RecordPosted then begin
            SSDWMSSyncStatus.Get(Rec."Entry No.");
            SSDWMSSyncStatus.Posted:=true;
            SSDWMSSyncStatus.Modify();
        end;
    end;
    var SSDQualityManagement: Codeunit "SSD Quality Management";
}
