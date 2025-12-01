codeunit 60001 "SSD Gate Entry Post (Yes/No)"
{
    TableNo = "Gate Entry Header";

    trigger OnRun()
    begin
        GateEntryHeader.Copy(Rec);
        Code();
        Rec:=GateEntryHeader;
    end;
    var GateEntryHeader: Record "Gate Entry Header";
    GateEntryPost: Codeunit "SSD Gate Entry Post";
    ConfirmPostLbl: Label 'Do you want to Post the Gate Entry?';
    SuccessfullyLbl: Label 'Gate Entry Posted successfully.';
    local procedure Code()
    begin
        if not Confirm(ConfirmPostLbl, false)then exit;
        GateEntryPost.Run(GateEntryHeader);
        Message(SuccessfullyLbl);
    end;
}
