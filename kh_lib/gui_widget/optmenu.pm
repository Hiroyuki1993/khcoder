package gui_widget::optmenu;
use strict;
use Tk;
use Jcode;

# Perl 5.8の場合、decodeされた文字列がラベルとして与えられることが前提

sub open{
	my $self;
	my $class = shift;
	%{$self} = @_;
	bless $self, $class;
	
	# widthの決定
	foreach my $i (@{$self->{options}}){
		my $len;
		if ($] > 5.008){
			$len = length(Encode::encode('shiftjis',$i->[0]));
		} else {
			$len = length($i->[0]);
		}
		if ( $len > $self->{width} ){
			$self->{width} = $len;
		}
		$self->{values}{$i->[1]} = $i->[0];
	}

	# 本体作製
	$self->{win_obj} = $self->{parent}->Menubutton(
		-text        => '',
		-tearoff     => 'no',
		-relief      => 'raised',
		-indicator   => 'yes',
		-font        => "TKFN",
		-width       => $self->{width},
		-borderwidth => 1,
	)->pack(%{$self->{pack}});
	
	# オプション追加
	foreach my $i (@{$self->{options}}){
		$self->{win_obj}->radiobutton(
			-label     => " $i->[0]",
			-variable => \$self->{selection},
			-value    => $i->[1],
			-font     => "TKFN",
			-command  => sub{$self->mb_refresh}
		);
	}
	
	# デフォルト値を適用
	$self->{selection} = $self->{options}[0][1];
	$self->mb_refresh(5);
	
	return $self;
}

sub mb_refresh{
	my $self = shift;
	$self->{win_obj}->configure(-text,$self->{values}{$self->{selection}});
	$self->{win_obj}->update;
	${$self->{variable}} = $self->{selection};
	if ( defined($self->{command}) && $_[0] != 5){
		&{$self->{command}};
	}
}

sub set_value{
	my $self = shift;
	my $v    = shift;
	$self->{selection}   = $v;
	${$self->{variable}} = $v;
	$self->mb_refresh(5);
}

sub configure{
	my $self = shift;
	my %args = @_;
	$self->{win_obj}->configure(%args);
}

sub destroy{
	my $self = shift;
	$self->{win_obj}->destroy;
	undef $self;
}

1;
