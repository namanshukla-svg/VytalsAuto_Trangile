codeunit 60012 "SSD Sync Quality Status"
{
    trigger OnRun()
    begin
        SyncRecords();
    end;
    procedure SyncRecords()
    begin
        SSDWMSSyncStatus.Reset();
        SSDWMSSyncStatus.SetCurrentKey(Posted);
        SSDWMSSyncStatus.SetRange(Posted, false);
        if SSDWMSSyncStatus.FindSet()then repeat if SSDProcessQualityRecords.Run(SSDWMSSyncStatus)then;
                Commit();
            until SSDWMSSyncStatus.Next() = 0;
    end;
    var SSDWMSSyncStatus: Record "SSD WMS Sync Status";
    SSDProcessQualityRecords: Codeunit "SSD Process Quality Records";
}
