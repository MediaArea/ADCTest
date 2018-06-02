Name:           adctest
Version:        110
Release:        1
Summary:        Analog-digital converter performance testing tool

Group:          Applications/Multimedia
License:        BSD-3-Clause
URL:            http://MediaArea.net/ADCTest
Packager:       MediaArea.net SARL <info@mediaarea.net>
Source0:        %{name}_%{version}.tar.gz

BuildRoot:      %{_tmppath}/%{name}-%{version}-%{release}-root
BuildRequires:  gcc-c++
BuildRequires:  pkgconfig
BuildRequires:  libsndfile-devel
BuildRequires:  portaudio-devel
BuildRequires:  pkgconfig
BuildRequires:  libtool
BuildRequires:  automake
BuildRequires:  autoconf

# wxWidgets package name
%if 0%{?suse_version} && 0%{?suse_version} >= 1140
BuildRequires:  wxWidgets-devel
%else
%if 0%{?mageia}
%ifarch x86_64
BuildRequires:  lib64wxgtku3.0-devel
%else
BuildRequires:  libwxgtku3.0-devel
%endif
%else
BuildRequires:  wxGTK3-devel
%endif
%endif

%if 0%{?suse_version}
BuildRequires:  update-desktop-files
%endif
%if 0%{?fedora_version}
BuildRequires:  desktop-file-utils
%endif

%description
Analog-digital converter performance testing tool

%prep
%setup -q -n ADCTest
pushd Project/GNU/GUI
    autoreconf -i
popd

%build
export CFLAGS="%{optflags}"
export CXXFLAGS="%{optflags}"

pushd Project/GNU/GUI
    %if 0%{?mageia} > 5
        %configure --disable-dependency-tracking
    %else
        %configure
    %endif
    make %{?_smp_mflags}
popd


%install
pushd Project/GNU/GUI
    make install DESTDIR=%{buildroot}
popd

%if 0%{?suse_version}
  %suse_update_desktop_file -n adctest AudioVideo
%endif

%files
%defattr(-,root,root,-)
%{_bindir}/adctest
%{_datadir}/applications/*.desktop

%changelog
* Mon Jan 01 2018 Jerome Martinez <info@mediaarea.net>
- See History.txt for more info and real dates
