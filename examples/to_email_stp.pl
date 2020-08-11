#!/usr/bin/perl
use MIME::Lite;
use Net::SMTP;

$wdir="/home/develop/stp-output/maintenance_STP";
@files=`ls  $wdir/*\.log`;

### Adjust sender, recipient and your SMTP mailhost
my $from_address = 'healthchecks@ericsson.com';
my $to_address = 'francisco.zumbado@ericsson.com,daniel.r.rodriguez@ericsson.com,macsee.vallejos@ericsson.com,victor.padilla@ericsson.com,jose.riggioni@ericsson.com,roiner.jimenez@ericsson.com';
#my $to_address = 'francisco.zumbado@ericsson.com';
my $mail_host = 'localhost';

#### Adjust subject and body message
my $subject = 'Healtcheck CGSN, SBC ';
my $message_body = "Saludos,\n\nServidor NOC Tibas \n\nEricsson CR\n__________\n";

#### Create the multipart container
$msg = MIME::Lite->new (
        From => $from_address,
        To => $to_address,
        Subject => $subject,
        Type =>'multipart/mixed'
) or die "Error creating multipart container: $!\n";

### Add the text message part        
$msg->attach (
        Type => 'TEXT',
        Data => $message_body
) or die "Error adding the text message part: $!\n";            

foreach (@files) {
        chomp();
        $attach_file=$_;
        my $my_file_gif = $attach_file;
        print "Origen: $my_file_gif\t";
        my $your_file_gif = $my_file_gif;
        $your_file_gif =~ s/.*\/(.*)/$1/;
        print "$your_file_gif\n";

        ### Add the CSV file
        $msg->attach (
                Type => 'text/csv',
                Path => $my_file_gif,
                Filename => $your_file_gif,
                Disposition => 'attachment'
                ) or die "Error adding $file_gif: $!\n";
}
### Add the ZIP file
#$msg->attach (
#   Type => 'application/zip',
#   Path => $my_file_zip,
#   Filename => $your_file_zip,
#   Disposition => 'attachment'
#) or die "Error adding $file_zip: $!\n";

print "-------\n";
### Send the Message
MIME::Lite->send('smtp', $mail_host, Timeout=>60);
$msg->send or die "Error sending email $!\n";
system ("mv $wdir/*.log $wdir/sent");

print "DONE\n"
