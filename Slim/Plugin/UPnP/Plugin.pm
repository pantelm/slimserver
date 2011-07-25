package Slim::Plugin::UPnP::Plugin;

# $Id$
#
# UPnP/DLNA Media Interface
# Andy Grundman
# andy@slimdevices.com
#

use strict;
use base qw(Slim::Plugin::Base);

use Slim::Plugin::UPnP::Discovery;
use Slim::Plugin::UPnP::Events;
use Slim::Plugin::UPnP::MediaRenderer;
use Slim::Plugin::UPnP::MediaServer;
use Slim::Plugin::UPnP::SOAPServer;

use Slim::Utils::Prefs;
my $prefs = preferences('server');

use Slim::Utils::Log;

my $log = Slim::Utils::Log->addLogCategory( {
	category     => 'plugin.upnp',
	defaultLevel => 'ERROR',
	description  => 'PLUGIN_UPNP_MODULE_NAME',
} );

sub initPlugin {
	my $class = shift;
	
	if ( !defined $prefs->get('maxUPnPImageSize')) {
		$prefs->set('maxUPnPImageSize', 1920);
	}
	
	# Core UPnP function
	Slim::Plugin::UPnP::Discovery->init || return shutdownPlugin();
	Slim::Plugin::UPnP::Events->init    || return shutdownPlugin();
	Slim::Plugin::UPnP::SOAPServer->init;

	# Devices
	Slim::Plugin::UPnP::MediaServer->init;
	Slim::Plugin::UPnP::MediaRenderer->init;
}

sub shutdownPlugin {
	my $class = shift;
	
	Slim::Plugin::UPnP::MediaServer->shutdown;
	Slim::Plugin::UPnP::MediaRenderer->shutdown;
	
	Slim::Plugin::UPnP::SOAPServer->shutdown;
	Slim::Plugin::UPnP::Discovery->shutdown;
	Slim::Plugin::UPnP::Events->shutdown;
}

1;==== ORIGINAL VERSION server/Slim/Plugin/UPnP/Plugin.pm 131161242227677
package Slim::Plugin::UPnP::Plugin;

# $Id$
#
# UPnP/DLNA Media Interface
# Andy Grundman
# andy@slimdevices.com
#

use strict;
use base qw(Slim::Plugin::Base);

use Slim::Plugin::UPnP::Discovery;
use Slim::Plugin::UPnP::Events;
use Slim::Plugin::UPnP::MediaRenderer;
use Slim::Plugin::UPnP::MediaServer;
use Slim::Plugin::UPnP::SOAPServer;

use Slim::Utils::Log;

my $log = Slim::Utils::Log->addLogCategory( {
	category     => 'plugin.upnp',
	defaultLevel => 'ERROR',
	description  => 'PLUGIN_UPNP_MODULE_NAME',
} );

sub initPlugin {
	my $class = shift;
	
	# Core UPnP function
	Slim::Plugin::UPnP::Discovery->init || return shutdownPlugin();
	Slim::Plugin::UPnP::Events->init    || return shutdownPlugin();
	Slim::Plugin::UPnP::SOAPServer->init;

	# Devices
	Slim::Plugin::UPnP::MediaServer->init;
	Slim::Plugin::UPnP::MediaRenderer->init;
}

sub shutdownPlugin {
	my $class = shift;
	
	Slim::Plugin::UPnP::MediaServer->shutdown;
	Slim::Plugin::UPnP::MediaRenderer->shutdown;
	
	Slim::Plugin::UPnP::SOAPServer->shutdown;
	Slim::Plugin::UPnP::Discovery->shutdown;
	Slim::Plugin::UPnP::Events->shutdown;
}

1;==== THEIR VERSION server/Slim/Plugin/UPnP/Plugin.pm (/sd/slim/7.6/trunk) 131161242227677
