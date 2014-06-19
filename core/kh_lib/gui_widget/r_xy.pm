package gui_widget::r_xy;
use base qw(gui_widget);
use strict;
use Tk;
use Jcode;

sub _new{
	my $self = shift;
	
	my $win = $self->parent->Frame();
	my $fd  = $win->Frame()->pack(-fill => 'x');
	
	$self->{x} = 1 unless defined $self->{x};
	$self->{y} = 2 unless defined $self->{y};

	if ( length($self->{r_cmd}) ){
		if ( $self->{r_cmd} =~ /\nd_x <\- ([0-9]+)\nd_y <\- ([0-9]+)\n/ ){
			$self->{x} = $1;
			$self->{y} = $2;
		}
		$self->{r_cmd} = undef;
	}

	$fd->Label(
		-text => kh_msg->get('cmp_plot'), # �ץ��åȤ�����ʬ��
		-font => "TKFN",
	)->pack(-side => 'left');

	#$self->{entry_d_n} = $fd->Entry(
	#	-font       => "TKFN",
	#	-width      => 2,
	#	-background => 'white',
	#)->pack(-side => 'left', -padx => 2);
	#$self->{entry_d_n}->insert(0,'2');
	#$self->{entry_d_n}->bind("<Key-Return>",sub{$self->calc;});
	#$self->config_entry_focusin($self->{entry_d_n});

	$fd->Label(
		-text => kh_msg->get('x'), #  X��
		-font => "TKFN",
	)->pack(-side => 'left');

	$self->{entry_d_x} = $fd->Entry(
		-font       => "TKFN",
		-width      => 2,
		-background => 'white',
	)->pack(-side => 'left', -padx => 2);
	$self->{entry_d_x}->insert(0,$self->{x});
	$self->{entry_d_x}->bind("<Key-Return>",$self->{command})
		if defined( $self->{command} );
	gui_window->config_entry_focusin($self->{entry_d_x});

	$fd->Label(
		-text => kh_msg->get('y'), #  Y��
		-font => "TKFN",
	)->pack(-side => 'left');

	$self->{entry_d_y} = $fd->Entry(
		-font       => "TKFN",
		-width      => 2,
		-background => 'white',
	)->pack(-side => 'left', -padx => 2);
	$self->{entry_d_y}->insert(0,$self->{y});
	$self->{entry_d_y}->bind("<Key-Return>",$self->{command})
		if defined( $self->{command} );
	gui_window->config_entry_focusin($self->{entry_d_y});


	$self->{win_obj} = $win;
	return $self;
}

#----------------------#
#   ����ؤΥ�������   #

sub x{
	my $self = shift;
	return gui_window->gui_jg( $self->{entry_d_x}->get );
}

sub y{
	my $self = shift;
	return gui_window->gui_jg( $self->{entry_d_y}->get );
}

1;