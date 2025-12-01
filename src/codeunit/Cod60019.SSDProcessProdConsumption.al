codeunit 60019 "SSD Process Prod Consumption"
{
    TableNo = "Item Ledger Entry";
    Permissions = tabledata "Item Ledger Entry"=rm;

    trigger OnRun()
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        SSDSyncProduction: Codeunit "SSD Sync Production Actions";
        RecordSynced: Boolean;
    begin
        RecordSynced:=SSDSyncProduction.SyncProductionConsumption(Rec);
        if RecordSynced then begin
            ItemLedgerEntry.SetLoadFields("Entry No.", "SSD Entry Synced");
            ItemLedgerEntry.Get(Rec."Entry No.");
            ItemLedgerEntry."SSD Entry Synced":=true;
            ItemLedgerEntry.Modify();
            Commit();
        end;
    end;
}
