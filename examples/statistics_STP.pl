#!/usr/bin/perl -w
#-----------------------------------------------------#
#       Created by: Daniel Rodriguez Sanchez          # 
#       Assisted by: Francisco Zumbado                #
#               Ericsson                              #
#       Creation date: 14-12-2011                     #
#       Last update:   23-02-2012                     #
#          Estasdisticas     STP                      #
#-----------------------------------------------------# 

use Net::Telnet;
use MIME::Lite;
use Net::SMTP;

my $terminal="";
my $password="";
my $fecha=`date +%d%m%Y-%H`;
chomp($fecha);

print "\nInicio ".`date`;
print "Equipo: STP";
$logfile ="/home/develop/stp-input/statistics_TPS/STP_$fecha._input.log";
$file_name="/home/develop/stp-output/statistics_TPS/STP_$fecha._output.log";
$access='Claro@2012';
print "\nCreating Telnet";
        $telnet = new Net::Telnet ( Timeout=>10,input_log=>$file_name,  output_log=>$logfile,Errmode=>'return');
        $telnet->open("10.196.27.34");
print "\nAccessing Telnet";
        $telnet->waitfor('/> $/i');
        $telnet->print("23");
print "\nAccessing Terminal 23";
        $telnet->waitfor(String     => " Connection established as terminal 18./n");
        $telnet->print("login:uid=ericsson");
print "\nLogin as Ericsson";
        $telnet->waitfor(String     => "Enter Password :");
        $telnet->print("$access");
print "\nPassword Entered";
        $telnet->waitfor(String     => "Command Executed/n");
        $telnet->print("Rept-stat-iptps");
print "\nTPS checked";
        $telnet->waitfor(String     => "Command Executed/n");
        $telnet->print("Rept-stat-iptps:lsn=crher1els");
print "\nTPS from EIR checked";
        $telnet->waitfor(String     => "Command Executed/n");
        $telnet->print("Rept-stat-rtd");
print "\nCards checked";
        $telnet->waitfor(String     => "Command Executed/n");
        $telnet->print("logout");
print "\nLogout from Ericsson user";
        $telnet->waitfor(String     => "Command Executed/n");
        $telnet->close("10.196.27.34");
print"\nFinalizo ".`date`."\n";
