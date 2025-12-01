codeunit 60023 "SSD Auto Archive Management"
{
    procedure ArchiveDriver(var SSDDriver: Record "SSD Driver")
    var
        SSDDriverArchive: Record "SSD Driver Archive";
    begin
        SSDDriverArchive.Init();
        SSDDriverArchive.TransferFields(SSDDriver);
        SSDDriverArchive."Archive No.":=GetNextDriverArchiveVersion(SSDDriver);
        SSDDriverArchive.Insert();
        ResetDriver(SSDDriver);
    end;
    local procedure ResetDriver(var SSDDriver: Record "SSD Driver")
    begin
        SSDDriver.Name:='';
        SSDDriver."Identification Type":=SSDDriver."Identification Type";
        SSDDriver."Identification No.":='';
        SSDDriver.Modify();
    end;
    local procedure GetNextDriverArchiveVersion(SSDDriver: Record "SSD Driver")NextVersionNo: Integer var
        SSDDriverArchive: Record "SSD Driver Archive";
    begin
        SSDDriverArchive.Reset();
        SSDDriverArchive.SetRange(Code, SSDDriver.Code);
        if SSDDriverArchive.FindLast()then NextVersionNo+=SSDDriverArchive."Archive No."
        else
            NextVersionNo:=1;
    end;
}
