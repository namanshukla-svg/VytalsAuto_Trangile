tableextension 60011 "SSD Loc." extends Location
{
    fields
    {
        field(60000; "SSD Automated Plant"; Boolean)
        {
            Caption = 'Automated Plant';
            DataClassification = CustomerContent;
        }
        field(60001; "Allow Print On SI"; Boolean)
        {
            Caption = 'Allow Print On SI';
            DataClassification = CustomerContent;
        }
    }
}
