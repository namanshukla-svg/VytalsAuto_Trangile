codeunit 60025 "SSD Update Sync Entries"
{
    Permissions = tabledata "Item Ledger Entry"=rm;

    procedure RemoveWMSSync(ItemLedgerEntry: Record "Item Ledger Entry")
    begin
        if not ItemLedgerEntry."SSD Entry Synced" then exit;
        ItemLedgerEntry."SSD Entry Synced":=false;
        ItemLedgerEntry.Modify();
    end;
}
