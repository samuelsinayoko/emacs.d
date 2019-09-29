FasdUAS 1.101.10   ��   ��    k             l      ��  ��   ��
getItemMetadata.scpt --- get data to be passed to org-protocol from front application

Copyright (C) 2009, 2010 Christopher Suckling

Author:  Christopher Suckling <suckling at gmail dot com>
		Alexander Poslavsky <alexander.poslavsky at gmail.com>

This file is Free Software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 3, or (at your option)
any later version.

It is distributed in the hope that it will be useful, but WITHOUT
ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
License for more details.

You should have received a copy of the GNU General Public License
along with GNU Emacs; see the file COPYING.  If not, write to the
Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
Boston, MA 02110-1301, USA.

Vesion: 0.634

Commentary

Part of org-mac-protocol

Installation

1) Open in AppleScript Editor
2) Save as File Format: Script in  ~/Library/Scripts/orgQSLib/

Please see org-mac-protocol.org for full installation and usage instructions
     � 	 		 
 g e t I t e m M e t a d a t a . s c p t   - - -   g e t   d a t a   t o   b e   p a s s e d   t o   o r g - p r o t o c o l   f r o m   f r o n t   a p p l i c a t i o n 
 
 C o p y r i g h t   ( C )   2 0 0 9 ,   2 0 1 0   C h r i s t o p h e r   S u c k l i n g 
 
 A u t h o r :     C h r i s t o p h e r   S u c k l i n g   < s u c k l i n g   a t   g m a i l   d o t   c o m > 
 	 	 A l e x a n d e r   P o s l a v s k y   < a l e x a n d e r . p o s l a v s k y   a t   g m a i l . c o m > 
 
 T h i s   f i l e   i s   F r e e   S o f t w a r e ;   y o u   c a n   r e d i s t r i b u t e   i t   a n d / o r   m o d i f y 
 i t   u n d e r   t h e   t e r m s   o f   t h e   G N U   G e n e r a l   P u b l i c   L i c e n s e   a s   p u b l i s h e d   b y 
 t h e   F r e e   S o f t w a r e   F o u n d a t i o n ;   e i t h e r   v e r s i o n   3 ,   o r   ( a t   y o u r   o p t i o n ) 
 a n y   l a t e r   v e r s i o n . 
 
 I t   i s   d i s t r i b u t e d   i n   t h e   h o p e   t h a t   i t   w i l l   b e   u s e f u l ,   b u t   W I T H O U T 
 A N Y   W A R R A N T Y ;   w i t h o u t   e v e n   t h e   i m p l i e d   w a r r a n t y   o f   M E R C H A N T A B I L I T Y 
 o r   F I T N E S S   F O R   A   P A R T I C U L A R   P U R P O S E .     S e e   t h e   G N U   G e n e r a l   P u b l i c 
 L i c e n s e   f o r   m o r e   d e t a i l s . 
 
 Y o u   s h o u l d   h a v e   r e c e i v e d   a   c o p y   o f   t h e   G N U   G e n e r a l   P u b l i c   L i c e n s e 
 a l o n g   w i t h   G N U   E m a c s ;   s e e   t h e   f i l e   C O P Y I N G .     I f   n o t ,   w r i t e   t o   t h e 
 F r e e   S o f t w a r e   F o u n d a t i o n ,   I n c . ,   5 1   F r a n k l i n   S t r e e t ,   F i f t h   F l o o r , 
 B o s t o n ,   M A   0 2 1 1 0 - 1 3 0 1 ,   U S A . 
 
 V e s i o n :   0 . 6 3 4 
 
 C o m m e n t a r y 
 
 P a r t   o f   o r g - m a c - p r o t o c o l 
 
 I n s t a l l a t i o n 
 
 1 )   O p e n   i n   A p p l e S c r i p t   E d i t o r 
 2 )   S a v e   a s   F i l e   F o r m a t :   S c r i p t   i n     ~ / L i b r a r y / S c r i p t s / o r g Q S L i b / 
 
 P l e a s e   s e e   o r g - m a c - p r o t o c o l . o r g   f o r   f u l l   i n s t a l l a t i o n   a n d   u s a g e   i n s t r u c t i o n s 
   
  
 l     ��������  ��  ��        p         ������ 0 thelink theLink��        p         ������ 0 escerrorurl escErrorURL��        p         ������ "0 escerrormessage escErrorMessage��        p         ������ 0 escapp escApp��        l     ��������  ��  ��        i         I      �� ���� "0 getitemmetadata getItemMetadata       o      ���� 0 theprotocol theProtocol    !�� ! o      ���� 0 theapp theApp��  ��    k    , " "  # $ # l     ��������  ��  ��   $  % & % Z      ' (���� ' >     ) * ) l     +���� + c      , - , o     ���� 0 theapp theApp - m    ��
�� 
TEXT��  ��   * m     . . � / /  S a f a r i - T a b s ( I    �� 0���� 0 	linkerror 	linkError 0  1 2 1 o   	 
���� 0 theprotocol theProtocol 2  3�� 3 o   
 ���� 0 theapp theApp��  ��  ��  ��   &  4 5 4 l   ��������  ��  ��   5  6 7 6 Z   % 8 9�� : 8 =     ; < ; l    =���� = c     > ? > o    ���� 0 theapp theApp ? m    ��
�� 
TEXT��  ��   < m     @ @ � A A  S a f a r i 9 I    #�� B���� 0 
linksafari 
linkSafari B  C D C o    ���� 0 theprotocol theProtocol D  E�� E o    ���� 0 theapp theApp��  ��  ��   : Z   &% F G�� H F =   & + I J I l  & ) K���� K c   & ) L M L o   & '���� 0 theapp theApp M m   ' (��
�� 
TEXT��  ��   J m   ) * N N � O O  S a f a r i - T a b s G I   . 5�� P����  0 linksafaritabs linkSafariTabs P  Q R Q o   / 0���� 0 theprotocol theProtocol R  S�� S o   0 1���� 0 theapp theApp��  ��  ��   H Z   8% T U�� V T =   8 = W X W l  8 ; Y���� Y c   8 ; Z [ Z o   8 9���� 0 theapp theApp [ m   9 :��
�� 
TEXT��  ��   X m   ; < \ \ � ] ]  f i r e f o x - b i n U I   @ G�� ^���� 0 linkfirefox linkFirefox ^  _ ` _ o   A B���� 0 theprotocol theProtocol `  a�� a o   B C���� 0 theapp theApp��  ��  ��   V Z   J% b c�� d b =   J O e f e l  J M g���� g c   J M h i h o   J K���� 0 theapp theApp i m   K L��
�� 
TEXT��  ��   f m   M N j j � k k  G o o g l e   C h r o m e c I   R Y�� l���� 0 
linkchrome 
linkChrome l  m n m o   S T���� 0 theprotocol theProtocol n  o�� o o   T U���� 0 theapp theApp��  ��  ��   d Z   \% p q�� r p =   \ a s t s l  \ _ u���� u c   \ _ v w v o   \ ]���� 0 theapp theApp w m   ] ^��
�� 
TEXT��  ��   t m   _ ` x x � y y  S k i m q I   d k�� z���� 0 linkskim linkSkim z  { | { o   e f���� 0 theprotocol theProtocol |  }�� } o   f g���� 0 theapp theApp��  ��  ��   r Z   n% ~ �� � ~ =   n s � � � l  n q ����� � c   n q � � � o   n o���� 0 theapp theApp � m   o p��
�� 
TEXT��  ��   � m   q r � � � � �  B i b D e s k  I   v }�� ����� 0 linkbibdesk linkBibDesk �  � � � o   w x���� 0 theprotocol theProtocol �  ��� � o   x y���� 0 theapp theApp��  ��  ��   � Z   �% � ��� � � =   � � � � � l  � � ����� � c   � � � � � o   � ����� 0 theapp theApp � m   � ���
�� 
TEXT��  ��   � m   � � � � � � � 
 P a g e s � I   � ��� ����� 0 	linkpages 	linkPages �  � � � o   � ����� 0 theprotocol theProtocol �  ��� � o   � ����� 0 theapp theApp��  ��  ��   � Z   �% � ��� � � =   � � � � � l  � � ����� � c   � � � � � o   � ����� 0 theapp theApp � m   � ���
�� 
TEXT��  ��   � m   � � � � � � �  N u m b e r s � I   � ��� ����� 0 linknumbers linkNumbers �  � � � o   � ����� 0 theprotocol theProtocol �  ��� � o   � ����� 0 theapp theApp��  ��  ��   � Z   �% � ��� � � =   � � � � � l  � � ����� � c   � � � � � o   � ����� 0 theapp theApp � m   � ���
�� 
TEXT��  ��   � m   � � � � � � �  K e y n o t e � I   � ��� ����� 0 linkkeynote linkKeynote �  � � � o   � ����� 0 theprotocol theProtocol �  ��� � o   � ����� 0 theapp theApp��  ��  ��   � Z   �% � �� � � =   � � � � � l  � � ��~�} � c   � � � � � o   � ��|�| 0 theapp theApp � m   � ��{
�{ 
TEXT�~  �}   � m   � � � � � � �  M a i l � I   � ��z ��y�z 0 linkmail linkMail �  � � � o   � ��x�x 0 theprotocol theProtocol �  ��w � o   � ��v�v 0 theapp theApp�w  �y  �   � Z   �% � ��u � � =   � � � � � l  � � ��t�s � c   � � � � � o   � ��r�r 0 theapp theApp � m   � ��q
�q 
TEXT�t  �s   � m   � � � � � � �  A d d r e s s   B o o k � I   � ��p ��o�p "0 linkaddressbook linkAddressBook �  � � � o   � ��n�n 0 theprotocol theProtocol �  ��m � o   � ��l�l 0 theapp theApp�m  �o  �u   � Z   �% � ��k � � =   � � � � � l  � � ��j�i � c   � � � � � o   � ��h�h 0 theapp theApp � m   � ��g
�g 
TEXT�j  �i   � m   � � � � � � �  i T u n e s � I   � ��f ��e�f 0 
linkitunes 
linkITunes �  � � � o   � ��d�d 0 theprotocol theProtocol �  ��c � o   � ��b�b 0 theapp theApp�c  �e  �k   � Z   �% � ��a � � =   � � � � � l  � � ��`�_ � c   � � � � � o   � ��^�^ 0 theapp theApp � m   � ��]
�] 
TEXT�`  �_   � m   � � � � � � �  T e r m i n a l � I   �\ ��[�\ 0 linkterminal linkTerminal �  � � � o  �Z�Z 0 theprotocol theProtocol �  ��Y � o  �X�X 0 theapp theApp�Y  �[  �a   � Z  
% � ��W � � =  
 � � � l 
 ��V�U � c  
 � � � o  
�T�T 0 theapp theApp � m  �S
�S 
TEXT�V  �U   � m   � � � � �  F i n d e r � I  �R ��Q�R 0 
linkfinder 
linkFinder �  � � � o  �P�P 0 theprotocol theProtocol �  ��O � o  �N�N 0 theapp theApp�O  �Q  �W   � I  %�M ��L�M "0 linkapplication linkApplication �  � � � o   �K�K 0 theprotocol theProtocol �  ��J � o   !�I�I 0 theapp theApp�J  �L   7    l &&�H�G�F�H  �G  �F    L  &* o  &)�E�E 0 thelink theLink �D l ++�C�B�A�C  �B  �A  �D     l     �@�?�>�@  �?  �>   	 i    

 I      �=�<�= (0 encodeuricomponent encodeURIComponent �; o      �:�: 0 theuri theURI�;  �<   k       p       �9�8�9 0 	escapelib 	escapeLib�8   �7 r      I    �6�5
�6 .sysoexecTEXT���     TEXT b      b      b      m      � 
 r u b y   l   �4�3 n      1    �2
�2 
psxp  o    �1�1 0 	escapelib 	escapeLib�4  �3   m    !! �""    n    
#$# 1    
�0
�0 
strq$ o    �/�/ 0 theuri theURI�5   o      �.�. 0 escuri escURI�7  	 %&% l     �-�,�+�-  �,  �+  & '(' l     �*�)�(�*  �)  �(  ( )*) l      �'+,�'  +$Format of links:

org-protocol:/protocol:/key/URI/description/short description/content:application name

theProtocol - org-protocol:/protocol:/key/
theApp - application name

short description - for remember templates; removes theApp and other contextual information from description   , �--<  F o r m a t   o f   l i n k s : 
 
 o r g - p r o t o c o l : / p r o t o c o l : / k e y / U R I / d e s c r i p t i o n / s h o r t   d e s c r i p t i o n / c o n t e n t : a p p l i c a t i o n   n a m e 
 
 t h e P r o t o c o l   -   o r g - p r o t o c o l : / p r o t o c o l : / k e y / 
 t h e A p p   -   a p p l i c a t i o n   n a m e 
 
 s h o r t   d e s c r i p t i o n   -   f o r   r e m e m b e r   t e m p l a t e s ;   r e m o v e s   t h e A p p   a n d   o t h e r   c o n t e x t u a l   i n f o r m a t i o n   f r o m   d e s c r i p t i o n * ./. l     �&�%�$�&  �%  �$  / 010 i    232 I      �#4�"�# 0 	linkerror 	linkError4 565 o      �!�! 0 theprotocol theProtocol6 7� 7 o      �� 0 theapp theApp�   �"  3 k     -88 9:9 r     ;<; n     
=>= 1    
�
� 
psxp> l    ?��? I    �@�
� .earsffdralis        afdr@ 4     �A
� 
cappA o    �� 0 theapp theApp�  �  �  < o      �� 0 theerrorurl theErrorURL: BCB r    DED b    FGF o    �� 0 theapp theAppG m    HH �II 0 :   n o   A p p l e S c r i p t   s u p p o r tE o      �� "0 theerrormessage theErrorMessageC JKJ r    LML I    �N�� (0 encodeuricomponent encodeURIComponentN O�O o    �� 0 theerrorurl theErrorURL�  �  M o      �� 0 escerrorurl escErrorURLK PQP r    $RSR I    "�T�� (0 encodeuricomponent encodeURIComponentT U�U o    �� "0 theerrormessage theErrorMessage�  �  S o      �� "0 escerrormessage escErrorMessageQ V�
V r   % -WXW I   % +�	Y��	 (0 encodeuricomponent encodeURIComponentY Z�Z o   & '�� 0 theapp theApp�  �  X o      �� 0 escapp escApp�
  1 [\[ l     ����  �  �  \ ]^] i    _`_ I      �a� � 0 
linksafari 
linkSafaria bcb o      ���� 0 theprotocol theProtocolc d��d o      ���� 0 theapp theApp��  �   ` k     mee fgf O     3hih k    2jj klk r    mnm I   ��op
�� .sfridojs****       utxto m    qq �rr  d o c u m e n t . U R Lp ��s��
�� 
dcnms 4    
��t
�� 
docut m    	���� ��  n o      ���� 0 theurl theURLl uvu r    wxw l   y����y I   ��z{
�� .sfridojs****       utxtz m    || �}}  d o c u m e n t . t i t l e{ ��~��
�� 
dcnm~ 4    ��
�� 
docu m    ���� ��  ��  ��  x o      ���� 0 theshorttitle theShortTitlev ��� r    %��� b    #��� b    !��� o    ���� 0 theshorttitle theShortTitle� m     �� ���  :� o   ! "���� 0 theapp theApp� o      ���� 0 thetitle theTitle� ���� r   & 2��� I  & 0����
�� .sfridojs****       utxt� m   & '�� ��� * w i n d o w . g e t S e l e c t i o n ( )� �����
�� 
dcnm� 4   ( ,���
�� 
docu� m   * +���� ��  � o      ���� 0 
thecontent 
theContent��  i m     ���                                                                                  sfri  alis    :  rushka                     �/�SH+   3��
Safari.app                                                      6��;�)        ����  	                Applications    �/�C      �;�     3��  rushka:Applications:Safari.app   
 S a f a r i . a p p    r u s h k a  Applications/Safari.app   / ��  g ��� l  4 4��������  ��  ��  � ��� r   4 <��� I   4 :������� (0 encodeuricomponent encodeURIComponent� ���� o   5 6���� 0 theurl theURL��  ��  � o      ���� 0 escurl escURL� ��� r   = E��� I   = C������� (0 encodeuricomponent encodeURIComponent� ���� o   > ?���� 0 theshorttitle theShortTitle��  ��  � o      ���� 0 escshorttitle escShortTitle� ��� r   F N��� I   F L������� (0 encodeuricomponent encodeURIComponent� ���� o   G H���� 0 thetitle theTitle��  ��  � o      ���� 0 esctitle escTitle� ��� r   O W��� I   O U������� (0 encodeuricomponent encodeURIComponent� ���� o   P Q���� 0 
thecontent 
theContent��  ��  � o      ���� 0 
esccontent 
escContent� ��� l  X X��������  ��  ��  � ���� r   X m��� b   X k��� b   X i��� b   X g��� b   X e��� b   X c��� b   X a��� b   X _��� b   X ]��� b   X [��� o   X Y���� 0 theprotocol theProtocol� o   Y Z���� 0 escurl escURL� m   [ \�� ���  /� o   ] ^���� 0 esctitle escTitle� m   _ `�� ���  /� o   a b���� 0 escshorttitle escShortTitle� m   c d�� ���  /� o   e f���� 0 
esccontent 
escContent� m   g h�� ���  :� o   i j���� 0 escapp escApp� o      ���� 0 thelink theLink��  ^ ��� l     ��������  ��  ��  � ��� i    ��� I      �������  0 linksafaritabs linkSafariTabs� ��� o      ���� 0 theprotocol theProtocol� ���� o      ���� 0 theapp theApp��  ��  � k     d�� ��� O     ^��� k    ]�� ��� r    ��� n    
��� 2   
��
�� 
bTab� 4    ���
�� 
cwin� m    ���� � o      ���� 0 thetabs theTabs� ��� r    ��� J    ����  � o      ���� 0 thelinklist theLinkList� ���� X    ]����� k   " X�� ��� r   " +��� l  " )������ I  " )����
�� .sfridojs****       utxt� m   " #�� ���  d o c u m e n t . U R L� �����
�� 
dcnm� o   $ %���� 0 eachtab eachTab��  ��  ��  � o      ���� 0 theurl theURL� ��� r   , 5��� l  , 3������ I  , 3����
�� .sfridojs****       utxt� m   , -�� ���  d o c u m e n t . t i t l e� �����
�� 
dcnm� o   . /���� 0 eachtab eachTab��  ��  ��  � o      ���� 0 thetitle theTitle�    r   6 > n   6 < I   7 <������ (0 encodeuricomponent encodeURIComponent �� o   7 8���� 0 theurl theURL��  ��    f   6 7 o      ���� 0 escurl escURL 	 r   ? G

 n   ? E I   @ E������ (0 encodeuricomponent encodeURIComponent �� o   @ A���� 0 thetitle theTitle��  ��    f   ? @ o      ���� 0 esctitle escTitle	  r   H S b   H Q b   H O b   H M b   H K o   H I���� 0 escurl escURL m   I J �  / o   K L���� 0 esctitle escTitle m   M N �  / m   O P   �!!  : : o      ���� 0 eachlink eachLink "��" s   T X#$# o   T U���� 0 eachlink eachLink$ n      %&%  ;   V W& o   U V���� 0 thelinklist theLinkList��  �� 0 eachtab eachTab� o    ���� 0 thetabs theTabs��  � m     ''�                                                                                  sfri  alis    :  rushka                     �/�SH+   3��
Safari.app                                                      6��;�)        ����  	                Applications    �/�C      �;�     3��  rushka:Applications:Safari.app   
 S a f a r i . a p p    r u s h k a  Applications/Safari.app   / ��  � ()( l  _ _��������  ��  ��  ) *��* r   _ d+,+ b   _ b-.- o   _ `���� 0 theprotocol theProtocol. o   ` a���� 0 thelinklist theLinkList, o      ���� 0 thelink theLink��  � /0/ l     ��������  ��  ��  0 121 i    343 I      ��5���� 0 linkfirefox linkFirefox5 676 o      ���� 0 theprotocol theProtocol7 8��8 o      ���� 0 theapp theApp��  ��  4 k     �99 :;: O     S<=< k    R>> ?@? I   	������
�� .miscactvnull��� ��� null��  ��  @ ABA r   
 CDC I  
 �����
�� .JonsgClp****    ��� null��  �  D o      �~�~ 0 oldclipboard oldClipboardB EFE O    &GHG k    %II JKJ I   �}LM
�} .prcskprsnull���    utxtL m    NN �OO  lM �|P�{
�| 
faalP m    �z
�z eMdsKcmd�{  K Q�yQ I   %�xRS
�x .prcskprsnull���    utxtR m    TT �UU  cS �wV�v
�w 
faalV m     !�u
�u eMdsKcmd�v  �y  H m    WW�                                                                                  sevs  alis    |  rushka                     �/�SH+   3��System Events.app                                               4�+�85G        ����  	                CoreServices    �/�C      �8'7     3�� 3І 3Ѕ  4rushka:System:Library:CoreServices:System Events.app  $  S y s t e m   E v e n t s . a p p    r u s h k a  -System/Library/CoreServices/System Events.app   / ��  F XYX I  ' ,�tZ�s
�t .sysodelanull��� ��� nmbrZ m   ' ([[ ?�333333�s  Y \]\ r   - 4^_^ I  - 2�r�q�p
�r .JonsgClp****    ��� null�q  �p  _ o      �o�o 0 theurl theURL] `a` I  5 :�nb�m
�n .JonspClpnull���     ****b o   5 6�l�l 0 oldclipboard oldClipboard�m  a cdc r   ; Defe l  ; Bg�k�jg e   ; Bhh n   ; Biji 1   ? A�i
�i 
pnamj 4   ; ?�hk
�h 
cwink m   = >�g�g �k  �j  f o      �f�f 0 theshorttitle theShortTitled lml r   E Jnon b   E Hpqp o   E F�e�e 0 theshorttitle theShortTitleq m   F Grr �ss  : F i r e f o xo o      �d�d 0 thetitle theTitlem t�ct r   K Ruvu I  K P�b�a�`
�b .JonsgClp****    ��� null�a  �`  v o      �_�_ 0 
thecontent 
theContent�c  = m     ww�                                                                                  MOZB  alis    >  rushka                     �/�SH+   3��Firefox.app                                                     w���v��        ����  	                Applications    �/�C      �v��     3��  rushka:Applications:Firefox.app     F i r e f o x . a p p    r u s h k a  Applications/Firefox.app  / ��  ; xyx l  T T�^�]�\�^  �]  �\  y z{z r   T \|}| I   T Z�[~�Z�[ (0 encodeuricomponent encodeURIComponent~ �Y o   U V�X�X 0 theurl theURL�Y  �Z  } o      �W�W 0 escurl escURL{ ��� r   ] e��� I   ] c�V��U�V (0 encodeuricomponent encodeURIComponent� ��T� o   ^ _�S�S 0 theshorttitle theShortTitle�T  �U  � o      �R�R 0 escshorttitle escShortTitle� ��� r   f n��� I   f l�Q��P�Q (0 encodeuricomponent encodeURIComponent� ��O� o   g h�N�N 0 thetitle theTitle�O  �P  � o      �M�M 0 esctitle escTitle� ��� r   o w��� I   o u�L��K�L (0 encodeuricomponent encodeURIComponent� ��J� o   p q�I�I 0 
thecontent 
theContent�J  �K  � o      �H�H 0 
esccontent 
escContent� ��� l  x x�G�F�E�G  �F  �E  � ��D� r   x ���� b   x ���� b   x ���� b   x ���� b   x ���� b   x ���� b   x ���� b   x ��� b   x {��� o   x y�C�C 0 theprotocol theProtocol� o   y z�B�B 0 escurl escURL� m   { ~�� ���  /� o    ��A�A 0 esctitle escTitle� m   � ��� ���  /� o   � ��@�@ 0 escshorttitle escShortTitle� m   � ��� ���  /� o   � ��?�? 0 
esccontent 
escContent� m   � ��� ���  : F i r e f o x� o      �>�> 0 thelink theLink�D  2 ��� l     �=�<�;�=  �<  �;  � ��� i    ��� I      �:��9�: 0 
linkchrome 
linkChrome� ��� o      �8�8 0 theprotocol theProtocol� ��7� o      �6�6 0 theapp theApp�7  �9  � k     ��� ��� r     ��� I    �5�4�3
�5 .JonsgClp****    ��� null�4  �3  � o      �2�2 0 oldclipboard oldClipboard� ��� O    O��� k    N�� ��� O     ��� k    �� ��� I   �1��
�1 .prcskprsnull���    utxt� m    �� ���  l� �0��/
�0 
faal� m    �.
�. eMdsKcmd�/  � ��-� I   �,��
�, .prcskprsnull���    utxt� m    �� ���  c� �+��*
�+ 
faal� m    �)
�) eMdsKcmd�*  �-  � m    ���                                                                                  sevs  alis    |  rushka                     �/�SH+   3��System Events.app                                               4�+�85G        ����  	                CoreServices    �/�C      �8'7     3�� 3І 3Ѕ  4rushka:System:Library:CoreServices:System Events.app  $  S y s t e m   E v e n t s . a p p    r u s h k a  -System/Library/CoreServices/System Events.app   / ��  � ��� I  ! &�(��'
�( .sysodelanull��� ��� nmbr� m   ! "�� ?�333333�'  � ��� r   ' .��� I  ' ,�&�%�$
�& .JonsgClp****    ��� null�%  �$  � o      �#�# 0 theurl theURL� ��� I  / 4�"��!
�" .JonspClpnull���     ****� o   / 0� �  0 oldclipboard oldClipboard�!  � ��� r   5 >��� l  5 <���� e   5 <�� n   5 <��� 1   9 ;�
� 
pnam� 4   5 9��
� 
cwin� m   7 8�� �  �  � o      �� 0 theshorttitle theShortTitle� ��� r   ? F��� b   ? D��� b   ? B��� o   ? @�� 0 theshorttitle theShortTitle� m   @ A�� ���  :� o   B C�� 0 theapp theApp� o      �� 0 thetitle theTitle� ��� r   G N��� I  G L���
� .JonsgClp****    ��� null�  �  � o      �� 0 
thecontent 
theContent�  � m    	���                                                                                  rimZ  alis    V  rushka                     �/�SH+   3��Google Chrome.app                                               �,���g^        ����  	                Applications    �/�C      ��g^     3��  %rushka:Applications:Google Chrome.app   $  G o o g l e   C h r o m e . a p p    r u s h k a  Applications/Google Chrome.app  / ��  � ��� l  P P����  �  �  � ��� r   P X��� I   P V���� (0 encodeuricomponent encodeURIComponent� ��� o   Q R�� 0 theurl theURL�  �  � o      �
�
 0 escurl escURL�    r   Y a I   Y _�	��	 (0 encodeuricomponent encodeURIComponent � o   Z [�� 0 theshorttitle theShortTitle�  �   o      �� 0 escshorttitle escShortTitle  r   b j	 I   b h�
�� (0 encodeuricomponent encodeURIComponent
 � o   c d�� 0 thetitle theTitle�  �  	 o      � �  0 esctitle escTitle  r   k s I   k q������ (0 encodeuricomponent encodeURIComponent �� o   l m���� 0 
thecontent 
theContent��  ��   o      ���� 0 
esccontent 
escContent  l  t t��������  ��  ��   �� r   t � b   t � b   t � b   t � b   t � b   t �  b   t !"! b   t {#$# b   t y%&% b   t w'(' o   t u���� 0 theprotocol theProtocol( o   u v���� 0 escurl escURL& m   w x)) �**  /$ o   y z���� 0 esctitle escTitle" m   { ~++ �,,  /  o    ����� 0 escshorttitle escShortTitle m   � �-- �..  / o   � ����� 0 
esccontent 
escContent m   � �// �00  : o   � ����� 0 escapp escApp o      ���� 0 thelink theLink��  � 121 l     ��������  ��  ��  2 343 l     ��������  ��  ��  4 565 i    787 I      ��9���� 0 linkskim linkSkim9 :;: o      ���� 0 theprotocol theProtocol; <��< o      ���� 0 theapp theApp��  ��  8 k     �== >?> O     M@A@ k    LBB CDC r    EFE m    GG �HH 
 s k i m :F o      ���� 0 	thescheme 	theSchemeD IJI r    KLK 4   ��M
�� 
docuM m   
 ���� L o      ���� 0 thedoc theDocJ NON r    PQP l   R����R n    STS 1    ��
�� 
pnamT o    ���� 0 thedoc theDoc��  ��  Q o      ���� 0 theshorttitle theShortTitleO UVU r    WXW b    YZY b    [\[ o    ���� 0 theshorttitle theShortTitle\ m    ]] �^^  :Z o    ���� 0 theapp theAppX o      ���� 0 thetitle theTitleV _`_ r    $aba b    "cdc l    e����e n     fgf 1     ��
�� 
ppthg o    ���� 0 thedoc theDoc��  ��  d m     !hh �ii  : :b o      ���� 0 thepath thePath` jkj r   % *lml n   % (non 1   & (��
�� 
seleo o   % &���� 0 thedoc theDocm o      ���� 0 theselection theSelectionk pqp r   + 4rsr n   + 2tut 1   0 2��
�� 
pcntu l  + 0v����v I  + 0��w��
�� .SKIMTextnull���     ****w o   + ,���� 0 theselection theSelection��  ��  ��  s o      ���� 0 
thecontent 
theContentq xyx Z   5 Bz{����z =  5 8|}| o   5 6���� 0 
thecontent 
theContent} m   6 7��
�� 
msng{ r   ; >~~ m   ; <�� ���   o      ���� 0 
thecontent 
theContent��  ��  y ���� r   C L��� l  C J������ I  C J�����
�� .SKIMIndxnull���     ****� n   C F��� 1   D F��
�� 
CPag� o   C D���� 0 thedoc theDoc��  ��  ��  � o      ���� 0 thepage thePage��  A m     ���                                                                                  SKim  alis    2  rushka                     �/�SH+   3��Skim.app                                                        ������        ����  	                Applications    �/�C      ���     3��  rushka:Applications:Skim.app    S k i m . a p p    r u s h k a  Applications/Skim.app   / ��  ? ��� l  N N��������  ��  ��  � ��� r   N V��� I   N T������� (0 encodeuricomponent encodeURIComponent� ���� o   O P���� 0 	thescheme 	theScheme��  ��  � o      ���� 0 	escscheme 	escScheme� ��� r   W _��� I   W ]������� (0 encodeuricomponent encodeURIComponent� ���� o   X Y���� 0 theshorttitle theShortTitle��  ��  � o      ���� 0 escshorttitle escShortTitle� ��� r   ` h��� I   ` f������� (0 encodeuricomponent encodeURIComponent� ���� o   a b���� 0 thetitle theTitle��  ��  � o      ���� 0 esctitle escTitle� ��� r   i q��� I   i o������� (0 encodeuricomponent encodeURIComponent� ���� o   j k���� 0 thepath thePath��  ��  � o      ���� 0 escpath escPath� ��� r   r z��� I   r x������� (0 encodeuricomponent encodeURIComponent� ���� o   s t���� 0 
thecontent 
theContent��  ��  � o      ���� 0 
esccontent 
escContent� ��� l  { {��������  ��  ��  � ���� r   { ���� b   { ���� b   { ���� b   { ���� b   { ���� b   { ���� b   { ���� b   { ���� b   { ���� b   { ���� b   { ���� b   { ~��� o   { |���� 0 theprotocol theProtocol� o   | }���� 0 	escscheme 	escScheme� o   ~ ���� 0 escpath escPath� o   � ����� 0 thepage thePage� m   � ��� ���  /� o   � ����� 0 esctitle escTitle� m   � ��� ���  /� o   � ����� 0 escshorttitle escShortTitle� m   � ��� ���  /� o   � ����� 0 
esccontent 
escContent� m   � ��� ���  :� o   � ����� 0 escapp escApp� o      ���� 0 thelink theLink��  6 ��� l     ��������  ��  ��  � ��� i     #��� I      ������� 0 linkbibdesk linkBibDesk� ��� o      ���� 0 theprotocol theProtocol� ���� o      ���� 0 theapp theApp��  ��  � k     ��� ��� O     P��� k    O�� ��� r    ��� m    �� ��� < $ p u b l i c a t i o n s > 
 < $ p u b T y p e = a r t i c l e ? > 
 < $ a u t h o r s . n a m e . @ c o m p o n e n t s J o i n e d B y C o m m a A n d A n d / >   < $ f i e l d s . Y e a r / > .   < $ f i e l d s . T i t l e / > .   < $ f i e l d s . J o u r n a l / > ,   < $ f i e l d s . V o l u m e / > ( < $ f i e l d s . N u m b e r / > ) ,   < $ f i e l d s . P a g e s / > . 
 < ? $ p u b T y p e = b o o k ? > 
 < $ a u t h o r s . n a m e . @ c o m p o n e n t s J o i n e d B y C o m m a A n d A n d / >   < $ f i e l d s . Y e a r / > .   < $ f i e l d s . T i t l e / > .   < $ f i e l d s . A d d r e s s / > :   < $ f i e l d s . P u b l i s h e r / > . 
 < ? $ p u b T y p e = u n p u b l i s h e d ? > 
 < $ a u t h o r s . n a m e . @ c o m p o n e n t s J o i n e d B y C o m m a A n d A n d / >   < $ f i e l d s . T i t l e / > .   < $ f i e l d s . N o t e / > 
 < ? $ p u b T y p e ? > 
 < $ a u t h o r s . n a m e . @ c o m p o n e n t s J o i n e d B y C o m m a A n d A n d / >   < $ f i e l d s . Y e a r / > .   < $ f i e l d s . T i t l e / > .   < $ f i e l d s . J o u r n a l / > ,   < $ f i e l d s . V o l u m e / > ( < $ f i e l d s . N u m b e r / > ) ,   < $ f i e l d s . P a g e s / > 
 < / $ p u b T y p e ? > 
 < / $ p u b l i c a t i o n s > 
� o      ���� 0 templatetext templateText� ��� r    ��� m    	�� ���  b i b d e s k :� o      ���� 0 	thescheme 	theScheme� ��� r    ��� 4   ���
�� 
docu� m    ���� � o      ���� 0 thedoc theDoc� ��� r    ��� b    ��� l   ������ n    ��� 1    ��
�� 
pnam� o    ���� 0 thedoc theDoc��  ��  � m    �� ���  : :� o      ���� 0 thetitle theTitle� ��� r    "��� b     ��� l   ������ n       1    �
� 
ppth o    �~�~ 0 thedoc theDoc��  ��  � m     �  : :� o      �}�} 0 thepath thePath�  r   # ( l  # &�|�{ n   # &	
	 1   $ &�z
�z 
sele
 o   # $�y�y 0 thedoc theDoc�|  �{   o      �x�x 0 theselection theSelection  r   ) / n   ) - 4   * -�w
�w 
cobj m   + ,�v�v  o   ) *�u�u 0 theselection theSelection o      �t�t 0 thepub thePub  r   0 ; I  0 9�s
�s .BDSKttxtnull���     docu o   0 1�r�r 0 thedoc theDoc �q
�q 
usTx o   2 3�p�p 0 templatetext templateText �o�n
�o 
for  o   4 5�m�m 0 thepub thePub�n   o      �l�l 0 thereference theReference  r   < A n   < ?  1   = ?�k
�k 
ckey  o   < =�j�j 0 thepub thePub o      �i�i 0 thecite theCite !"! r   B G#$# b   B E%&% m   B C'' �((  :& o   C D�h�h 0 theapp theApp$ o      �g�g 0 
theappname 
theAppName" )�f) r   H O*+* n   H M,-, 1   I M�e
�e 
keyw- o   H I�d�d 0 thepub thePub+ o      �c�c 0 thekeywords theKeywords�f  � m     ..�                                                                                  BDSK  alis    >  rushka                     �/�SH+   3��BibDesk.app                                                     }�ǧ��        ����  	                Applications    �/�C      ǧ��     3��  rushka:Applications:BibDesk.app     B i b D e s k . a p p    r u s h k a  Applications/BibDesk.app  / ��  � /0/ l  Q Q�b�a�`�b  �a  �`  0 121 r   Q Y343 I   Q W�_5�^�_ (0 encodeuricomponent encodeURIComponent5 6�]6 o   R S�\�\ 0 	thescheme 	theScheme�]  �^  4 o      �[�[ 0 	escscheme 	escScheme2 787 r   Z b9:9 I   Z `�Z;�Y�Z (0 encodeuricomponent encodeURIComponent; <�X< o   [ \�W�W 0 thetitle theTitle�X  �Y  : o      �V�V 0 esctitle escTitle8 =>= r   c k?@? I   c i�UA�T�U (0 encodeuricomponent encodeURIComponentA B�SB o   d e�R�R 0 thecite theCite�S  �T  @ o      �Q�Q 0 esccite escCite> CDC r   l vEFE I   l r�PG�O�P (0 encodeuricomponent encodeURIComponentG H�NH o   m n�M�M 0 thepath thePath�N  �O  F o      �L�L 0 escpath escPathD IJI r   w �KLK I   w }�KM�J�K (0 encodeuricomponent encodeURIComponentM N�IN o   x y�H�H 0 thereference theReference�I  �J  L o      �G�G 0 escreference escReferenceJ OPO r   � �QRQ I   � ��FS�E�F (0 encodeuricomponent encodeURIComponentS T�DT o   � ��C�C 0 
theappname 
theAppName�D  �E  R o      �B�B 0 
escappname 
escAppNameP UVU l  � ��A�@�?�A  �@  �?  V WXW r   � �YZY l  � �[�>�=[ I  � ��<\�;
�< .sysoexecTEXT���     TEXT\ b   � �]^] b   � �_`_ m   � �aa �bb  e c h o   "` o   � ��:�: 0 thekeywords theKeywords^ m   � �cc �dd , "   |   s e d   - e   ' s / [ ; , ] / / g '�;  �>  �=  Z o      �9�9  0 thekeywordssed theKeywordsSedX efe l  � ��8�7�6�8  �7  �6  f ghg r   � �iji b   � �klk b   � �mnm m   � �oo �pp 4 : P R O P E R T I E S : 
     : B I B D E S K :    n o   � ��5�5  0 thekeywordssed theKeywordsSedl m   � �qq �rr  
     : E N D :j o      �4�4 0 theproperty thePropertyh sts r   � �uvu b   � �wxw b   � �yzy o   � ��3�3 0 theproperty thePropertyz m   � �{{ �||  
 
    x o   � ��2�2 0 thereference theReferencev o      �1�1 0 
thecontent 
theContentt }~} r   � �� I   � ��0��/�0 (0 encodeuricomponent encodeURIComponent� ��.� o   � ��-�- 0 
thecontent 
theContent�.  �/  � o      �,�, 0 
esccontent 
escContent~ ��� l  � ��+�*�)�+  �*  �)  � ��� l  � ��(�'�&�(  �'  �&  � ��%� r   � ���� b   � ���� b   � ���� b   � ���� b   � ���� b   � ���� b   � ���� b   � ���� b   � ���� b   � ���� b   � ���� b   � ���� b   � ���� b   � ���� o   � ��$�$ 0 theprotocol theProtocol� o   � ��#�# 0 	escscheme 	escScheme� o   � ��"�" 0 escpath escPath� o   � ��!�! 0 esccite escCite� m   � ��� ���  /� o   � �� �  0 esctitle escTitle� o   � ��� 0 esccite escCite� o   � ��� 0 
escappname 
escAppName� m   � ��� ���  /� o   � ��� 0 esccite escCite� m   � ��� ���  /� o   � ��� 0 
esccontent 
escContent� m   � ��� ���  :� o   � ��� 0 escapp escApp� o      �� 0 thelink theLink�%  � ��� l     ����  �  �  � ��� i   $ '��� I      ���� 0 	linkpages 	linkPages� ��� o      �� 0 theprotocol theProtocol� ��� o      �� 0 theapp theApp�  �  � k     |�� ��� O     1��� k    0�� ��� r    ��� m    �� ���  p a g e s :� o      �� 0 	thescheme 	theScheme� ��� r    ��� 4   ��
� 
docu� m   
 �� � o      �� 0 thedoc theDoc� ��� r    ��� l   ���� n    ��� 1    �
� 
pnam� o    �
�
 0 thedoc theDoc�  �  � o      �	�	 0 theshorttitle theShortTitle� ��� r    ��� b    ��� b    ��� o    �� 0 theshorttitle theShortTitle� m    �� ���  :� o    �� 0 theapp theApp� o      �� 0 thetitle theTitle� ��� r    $��� b    "��� l    ���� n     ��� 1     �
� 
ppth� o    �� 0 thedoc theDoc�  �  � m     !�� ���  : :� o      �� 0 thepath thePath� ��� r   % *��� l  % (�� ��� n   % (��� 1   & (��
�� 
pSel� o   % &���� 0 thedoc theDoc�   ��  � o      ���� 0 
thecontent 
theContent� ���� r   + 0��� n   + .��� 1   , .��
�� 
ofse� o   + ,���� 0 
thecontent 
theContent� o      ���� 0 
thecharoff 
theCharOff��  � m     ���                                                                                  page  alis    L  rushka                     �/�SH+   bNl	Pages.app                                                       b�/���        ����  	                	iWork '09     �/�C      ��u�     bNl 3��  'rushka:Applications:iWork '09:Pages.app    	 P a g e s . a p p    r u s h k a   Applications/iWork '09/Pages.app  / ��  � ��� l  2 2��������  ��  ��  � ��� r   2 :��� I   2 8������� (0 encodeuricomponent encodeURIComponent� ���� o   3 4���� 0 	thescheme 	theScheme��  ��  � o      ���� 0 	escscheme 	escScheme� ��� r   ; C��� I   ; A������� (0 encodeuricomponent encodeURIComponent� ���� o   < =���� 0 theshorttitle theShortTitle��  ��  � o      ���� 0 escshorttitle escShortTitle� ��� r   D L   I   D J������ (0 encodeuricomponent encodeURIComponent �� o   E F���� 0 thetitle theTitle��  ��   o      ���� 0 esctitle escTitle�  r   M U I   M S������ (0 encodeuricomponent encodeURIComponent 	��	 o   N O���� 0 thepath thePath��  ��   o      ���� 0 escpath escPath 

 r   V ` I   V ^������ (0 encodeuricomponent encodeURIComponent �� c   W Z o   W X���� 0 
thecontent 
theContent m   X Y��
�� 
ctxt��  ��   o      ���� 0 
esccontent 
escContent  l  a a��������  ��  ��   �� r   a | b   a x b   a v b   a t b   a r b   a p  b   a n!"! b   a l#$# b   a j%&% b   a h'(' b   a f)*) b   a d+,+ o   a b���� 0 theprotocol theProtocol, o   b c���� 0 	escscheme 	escScheme* o   d e���� 0 escpath escPath( o   f g���� 0 
thecharoff 
theCharOff& m   h i-- �..  /$ o   j k���� 0 esctitle escTitle" m   l m// �00  /  o   n o���� 0 escshorttitle escShortTitle m   p q11 �22  / o   r s���� 0 
esccontent 
escContent m   t u33 �44  : o   v w���� 0 escapp escApp o      ���� 0 thelink theLink��  � 565 l     ��������  ��  ��  6 787 i   ( +9:9 I      ��;���� 0 linknumbers linkNumbers; <=< o      ���� 0 theprotocol theProtocol= >��> o      ���� 0 theapp theApp��  ��  : k    ?? @A@ O     �BCB k    �DD EFE r    GHG m    II �JJ  n u m b e r s :H o      ���� 0 	thescheme 	theSchemeF KLK r    MNM 4   ��O
�� 
docuO m   
 ���� N o      ���� 0 thedoc theDocL PQP r    RSR l   T����T n    UVU 1    ��
�� 
pnamV o    ���� 0 thedoc theDoc��  ��  S o      ���� 0 theshorttitle theShortTitleQ WXW r    YZY b    [\[ b    ]^] o    ���� 0 theshorttitle theShortTitle^ m    __ �``  :\ o    ���� 0 theapp theAppZ o      ���� 0 thetitle theTitleX aba r    $cdc b    "efe l    g����g n     hih 1     ��
�� 
ppthi o    ���� 0 thedoc theDoc��  ��  f m     !jj �kk  : :d o      ���� 0 thepath thePathb l��l O   % �mnm k   ) �oo pqp r   ) ,rsr m   ) *����  s o      ���� 0 thesheet theSheetq tut Y   - lv��wx��v k   = gyy z{z O   = W|}| r   D V~~ l  D T������ I  D T�����
�� .corecnte****       ****� l  D P������ 6  D P��� 2  D G��
�� 
NmTb� >  H O��� 1   I K��
�� 
NMTs� m   L N��
�� 
msng��  ��  ��  ��  ��   o      ���� 0 x  } 4   = A���
�� 
NmSh� o   ? @���� 0 i  { ���� Z   X g������� >  X [��� o   X Y���� 0 x  � m   Y Z����  � k   ^ c�� ��� r   ^ a��� o   ^ _���� 0 i  � o      ���� 0 thesheet theSheet� ����  S   b c��  ��  ��  ��  �� 0 i  w m   0 1���� x l  1 8������ I  1 8�����
�� .corecnte****       ****� 2  1 4��
�� 
NmSh��  ��  ��  ��  u ���� Z   m ������� =  m p��� o   m n���� 0 thesheet theSheet� m   n o����  � k   s ��� ��� r   s x��� b   s v��� m   s t���� � m   t u�� ���  : :� o      ���� 0 thesheet theSheet� ��� r   y ~��� b   y |��� m   y z���� � m   z {�� ���  : :� o      ���� 0 thetable theTable� ��� r    ���� m    ��� ��� 
 A 1 : A 1� o      ���� 0 therange theRange� ���� r   � ���� m   � ��� ���  � o      ���� 0 
thecontent 
theContent��  ��  � O   � ���� k   � ��� ��� r   � ���� 6  � ���� 4  � ����
�� 
NmTb� m   � ����� � >  � ���� 1   � ���
�� 
NMTs� m   � ���
�� 
msng� o      ���� 0 thetable theTable� ���� O   � ���� k   � ��� ��� r   � ���� b   � ���� l  � ������� c   � ���� o   � ����� 0 thesheet theSheet� m   � ���
�� 
ctxt��  ��  � m   � ��� ���  : :� o      ���� 0 thesheet theSheet� ��� r   � ���� b   � ���� l  � ����~� n   � ���� 1   � ��}
�} 
pnam� o   � ��|�| 0 thetable theTable�  �~  � m   � ��� ���  : :� o      �{�{ 0 thetable theTable� ��� r   � ���� l  � ���z�y� n   � ���� 1   � ��x
�x 
pnam� 1   � ��w
�w 
NMTs�z  �y  � o      �v�v 0 therange theRange� ��� r   � ���� n   � ���� 1   � ��u
�u 
NMCv� n   � ���� 2   � ��t
�t 
NmCl� 1   � ��s
�s 
NMTs� o      �r�r  0 therangevalues theRangeValues� ��� r   � ���� m   � ��� ���   � n     ��� 1   � ��q
�q 
txdl� 1   � ��p
�p 
ascr� ��� r   � ���� c   � ���� o   � ��o�o  0 therangevalues theRangeValues� m   � ��n
�n 
TEXT� o      �m�m 0 
thecontent 
theContent� ��l� r   � ���� m   � ��� ���  � n     � � 1   � ��k
�k 
txdl  1   � ��j
�j 
ascr�l  � o   � ��i�i 0 thetable theTable��  � 4   � ��h
�h 
NmSh o   � ��g�g 0 thesheet theSheet��  n o   % &�f�f 0 thedoc theDoc��  C m     �                                                                                  NMBR  alis    T  rushka                     �/�SH+   bNlNumbers.app                                                     b�����        ����  	                	iWork '09     �/�C      ��u�     bNl 3��  )rushka:Applications:iWork '09:Numbers.app     N u m b e r s . a p p    r u s h k a  "Applications/iWork '09/Numbers.app  / ��  A  l  � ��e�d�c�e  �d  �c    r   � � I   � ��b	�a�b (0 encodeuricomponent encodeURIComponent	 
�`
 o   � ��_�_ 0 	thescheme 	theScheme�`  �a   o      �^�^ 0 	escscheme 	escScheme  r   � I   ��]�\�] (0 encodeuricomponent encodeURIComponent �[ o   �Z�Z 0 theshorttitle theShortTitle�[  �\   o      �Y�Y 0 escshorttitle escShortTitle  r   I  �X�W�X (0 encodeuricomponent encodeURIComponent �V o  	
�U�U 0 thetitle theTitle�V  �W   o      �T�T 0 esctitle escTitle  r   I  �S�R�S (0 encodeuricomponent encodeURIComponent �Q o  �P�P 0 thepath thePath�Q  �R   o      �O�O 0 escpath escPath  r  (  I  $�N!�M�N (0 encodeuricomponent encodeURIComponent! "�L" o   �K�K 0 thesheet theSheet�L  �M    o      �J�J 0 escsheet escSheet #$# r  )3%&% I  )/�I'�H�I (0 encodeuricomponent encodeURIComponent' (�G( o  *+�F�F 0 thetable theTable�G  �H  & o      �E�E 0 esctable escTable$ )*) r  4>+,+ I  4:�D-�C�D (0 encodeuricomponent encodeURIComponent- .�B. o  56�A�A 0 therange theRange�B  �C  , o      �@�@ 0 escrange escRange* /0/ r  ?I121 I  ?E�?3�>�? (0 encodeuricomponent encodeURIComponent3 4�=4 o  @A�<�< 0 
thecontent 
theContent�=  �>  2 o      �;�; 0 
esccontent 
escContent0 565 l JJ�:�9�8�:  �9  �8  6 7�77 r  J898 b  J{:;: b  Jw<=< b  Js>?> b  Jo@A@ b  JkBCB b  JiDED b  JeFGF b  JaHIH b  J]JKJ b  JYLML b  JUNON b  JQPQP b  JMRSR o  JK�6�6 0 theprotocol theProtocolS o  KL�5�5 0 	escscheme 	escSchemeQ o  MP�4�4 0 escpath escPathO o  QT�3�3 0 escsheet escSheetM o  UX�2�2 0 esctable escTableK o  Y\�1�1 0 escrange escRangeI m  ]`TT �UU  /G o  ad�0�0 0 esctitle escTitleE m  ehVV �WW  /C o  ij�/�/ 0 escshorttitle escShortTitleA m  knXX �YY  /? o  or�.�. 0 
esccontent 
escContent= m  svZZ �[[  :; o  wz�-�- 0 escapp escApp9 o      �,�, 0 thelink theLink�7  8 \]\ l     �+�*�)�+  �*  �)  ] ^_^ i   , /`a` I      �(b�'�( 0 linkkeynote linkKeynoteb cdc o      �&�& 0 theprotocol theProtocold e�%e o      �$�$ 0 theapp theApp�%  �'  a k     �ff ghg O     >iji k    =kk lml r    non m    pp �qq  k e y n o t e :o o      �#�# 0 	thescheme 	theSchemem rsr r    tut 4   �"v
�" 
docuv m   
 �!�! u o      � �  0 thedoc theDocs wxw r    yzy l   {��{ n    |}| 1    �
� 
pnam} o    �� 0 thedoc theDoc�  �  z o      �� 0 theshorttitle theShortTitlex ~~ r    ��� b    ��� o    �� 0 theshorttitle theShortTitle� m    �� ���  : K e y n o t e� o      �� 0 thetitle theTitle ��� r    "��� b     ��� l   ���� n    ��� 1    �
� 
ppth� o    �� 0 thedoc theDoc�  �  � m    �� ���  : :� o      �� 0 thepath thePath� ��� r   # +��� l  # )���� n   # )��� 1   ' )�
� 
KnCS� 4  # '��
� 
docu� m   % &�� �  �  � o      �� 0 theslide theSlide� ��� r   , 1��� l  , /���� n   , /��� 1   - /�
� 
KSdN� o   , -�
�
 0 theslide theSlide�  �  � o      �	�	 0 theslideindex theSlideIndex� ��� r   2 =��� b   2 ;��� b   2 7��� l  2 5���� n   2 5��� 1   3 5�
� 
titl� o   2 3�� 0 theslide theSlide�  �  � m   5 6�� ���  
 	 
 	� l  7 :���� n   7 :��� 1   8 :�
� 
btxt� o   7 8� �  0 theslide theSlide�  �  � o      ���� 0 
thecontent 
theContent�  j m     ���                                                                                  keyn  alis    T  rushka                     �/�SH+   bNlKeynote.app                                                     bNm���        ����  	                	iWork '09     �/�C      ��u�     bNl 3��  )rushka:Applications:iWork '09:Keynote.app     K e y n o t e . a p p    r u s h k a  "Applications/iWork '09/Keynote.app  / ��  h ��� l  ? ?��������  ��  ��  � ��� r   ? G��� I   ? E������� (0 encodeuricomponent encodeURIComponent� ���� o   @ A���� 0 	thescheme 	theScheme��  ��  � o      ���� 0 	escscheme 	escScheme� ��� r   H P��� I   H N������� (0 encodeuricomponent encodeURIComponent� ���� o   I J���� 0 thepath thePath��  ��  � o      ���� 0 escpath escPath� ��� r   Q Y��� I   Q W������� (0 encodeuricomponent encodeURIComponent� ���� o   R S���� 0 thetitle theTitle��  ��  � o      ���� 0 esctitle escTitle� ��� r   Z b��� I   Z `������� (0 encodeuricomponent encodeURIComponent� ���� o   [ \���� 0 theshorttitle theShortTitle��  ��  � o      ���� 0 escshorttitle escShortTitle� ��� r   c k��� I   c i������� (0 encodeuricomponent encodeURIComponent� ���� o   d e���� 0 
thecontent 
theContent��  ��  � o      ���� 0 
esccontent 
escContent� ��� l  l l��������  ��  ��  � ��� r   l ���� b   l ���� b   l ���� b   l ��� b   l }��� b   l {��� b   l y��� b   l w��� b   l u��� b   l s��� b   l q��� b   l o��� o   l m���� 0 theprotocol theProtocol� o   m n���� 0 	escscheme 	escScheme� o   o p���� 0 escpath escPath� o   q r���� 0 theslideindex theSlideIndex� m   s t�� ���  /� o   u v���� 0 esctitle escTitle� m   w x�� ���  /� o   y z���� 0 escshorttitle escShortTitle� m   { |�� ���  /� o   } ~���� 0 
esccontent 
escContent� m    ��� ���  :� o   � ����� 0 escapp escApp� o      ���� 0 thelink theLink� ���� l  � ���������  ��  ��  ��  _ ��� l     ��������  ��  ��  � ��� i   0 3��� I      ������� 0 linkmail linkMail� ��� o      ���� 0 theprotocol theProtocol� ���� o      ���� 0 theapp theApp��  ��  � k     ���    O     = k    <  r    	 1    ��
�� 
slct o      ���� 0 theselection theSelection 	
	 X   
 8�� k    3  r     n     1    ��
�� 
meid o    ���� 0 
themessage 
theMessage o      ���� 0 theid theID  r     % l    #���� n     # 1   ! #��
�� 
subj o     !���� 0 
themessage 
theMessage��  ��   o      ���� "0 theshortsubject theShortSubject  r   & - b   & +  b   & )!"! o   & '���� "0 theshortsubject theShortSubject" m   ' (## �$$  :  o   ) *���� 0 theapp theApp o      ���� 0 
thesubject 
theSubject %��% r   . 3&'& n   . 1()( 1   / 1��
�� 
ctnt) o   . /���� 0 
themessage 
theMessage' o      ���� 0 
thecontent 
theContent��  �� 0 
themessage 
theMessage o    ���� 0 theselection theSelection
 *��* r   9 <+,+ m   9 :-- �..  m e s s a g e : / /, o      ���� 0 	thescheme 	theScheme��   m     //�                                                                                  emal  alis    2  rushka                     �/�SH+   3��Mail.app                                                        6(Ə/        ����  	                Applications    �/�C      Ǝ�     3��  rushka:Applications:Mail.app    M a i l . a p p    r u s h k a  Applications/Mail.app   / ��   010 l  > >��������  ��  ��  1 232 r   > F454 I   > D��6���� (0 encodeuricomponent encodeURIComponent6 7��7 o   ? @���� 0 theid theID��  ��  5 o      ���� 0 escid escID3 898 r   G O:;: I   G M��<���� (0 encodeuricomponent encodeURIComponent< =��= o   H I���� "0 theshortsubject theShortSubject��  ��  ; o      ���� "0 escshortsubject escShortSubject9 >?> r   P X@A@ I   P V��B���� (0 encodeuricomponent encodeURIComponentB C��C o   Q R���� 0 
thesubject 
theSubject��  ��  A o      ���� 0 
escsubject 
escSubject? DED r   Y aFGF I   Y _��H���� (0 encodeuricomponent encodeURIComponentH I��I o   Z [���� 0 	thescheme 	theScheme��  ��  G o      ���� 0 	escscheme 	escSchemeE JKJ r   b jLML I   b h��N���� (0 encodeuricomponent encodeURIComponentN O��O o   c d���� 0 
thecontent 
theContent��  ��  M o      ���� 0 
esccontent 
escContentK PQP l  k k��������  ��  ��  Q R��R r   k �STS b   k �UVU b   k ~WXW b   k |YZY b   k z[\[ b   k x]^] b   k v_`_ b   k taba b   k rcdc b   k pefe b   k nghg o   k l���� 0 theprotocol theProtocolh o   l m���� 0 	escscheme 	escSchemef o   n o���� 0 escid escIDd m   p qii �jj  /b o   r s���� 0 
escsubject 
escSubject` m   t ukk �ll  /^ o   v w���� "0 escshortsubject escShortSubject\ m   x ymm �nn  /Z o   z {���� 0 
esccontent 
escContentX m   | }oo �pp  :V o   ~ ���� 0 escapp escAppT o      ���� 0 thelink theLink��  � qrq l     ��������  ��  ��  r sts i   4 7uvu I      ��w���� "0 linkaddressbook linkAddressBookw xyx o      ���� 0 theprotocol theProtocoly z��z o      ���� 0 theapp theApp��  ��  v k     i{{ |}| l      ��~��  ~  By Alexander Poslavsky    ��� 0  B y   A l e x a n d e r   P o s l a v s k y } ��� O     >��� k    =�� ��� r    ��� m    �� ���  a d d r e s s :� o      ���� 0 	thescheme 	theScheme� ��� r    ��� 1    ��
�� 
az48� o      ���� 0 allcontacts AllContacts� ���� Z    =������ =    ��� n    ��� m    �
� 
nmbr� n   ��� 2   �~
�~ 
cobj� o    �}�} 0 allcontacts AllContacts� m    �|�| � k    *�� ��� r    ��� n    ��� 4    �{�
�{ 
cobj� m    �z�z � o    �y�y 0 allcontacts AllContacts� o      �x�x 0 one_contact  � ��� r    $��� n    "��� 1     "�w
�w 
ID  � o     �v�v 0 one_contact  � o      �u�u 0 theid theID� ��t� r   % *��� n   % (��� 1   & (�s
�s 
pnam� o   % &�r�r 0 one_contact  � o      �q�q 0 thename theName�t  ��  � O   - =��� k   1 <�� ��� I  1 6�p�o�n
�p .miscactvnull��� ��� null�o  �n  � ��m� I  7 <�l��k
�l .sysodlogaskr        TEXT� m   7 8�� ��� 2 E r r o r :   C h o o s e   o n e   c o n t a c t�k  �m  � m   - .���                                                                                  sevs  alis    |  rushka                     �/�SH+   3��System Events.app                                               4�+�85G        ����  	                CoreServices    �/�C      �8'7     3�� 3І 3Ѕ  4rushka:System:Library:CoreServices:System Events.app  $  S y s t e m   E v e n t s . a p p    r u s h k a  -System/Library/CoreServices/System Events.app   / ��  ��  � m     ���                                                                                  adrb  alis    R  rushka                     �/�SH+   3��Address Book.app                                                6F�ƐX�        ����  	                Applications    �/�C      ƐJu     3��  $rushka:Applications:Address Book.app  "  A d d r e s s   B o o k . a p p    r u s h k a  Applications/Address Book.app   / ��  � ��� l  ? ?�j�i�h�j  �i  �h  � ��� r   ? G��� I   ? E�g��f�g (0 encodeuricomponent encodeURIComponent� ��e� o   @ A�d�d 0 theid theID�e  �f  � o      �c�c 0 escid escID� ��� r   H P��� I   H N�b��a�b (0 encodeuricomponent encodeURIComponent� ��`� o   I J�_�_ 0 thename theName�`  �a  � o      �^�^ 0 escname escName� ��� r   Q Y��� I   Q W�]��\�] (0 encodeuricomponent encodeURIComponent� ��[� o   R S�Z�Z 0 	thescheme 	theScheme�[  �\  � o      �Y�Y 0 	escscheme 	escScheme� ��X� r   Z i��� b   Z g��� b   Z e��� b   Z c��� b   Z a��� b   Z _��� b   Z ]��� o   Z [�W�W 0 theprotocol theProtocol� o   [ \�V�V 0 	escscheme 	escScheme� o   ] ^�U�U 0 escid escID� m   _ `�� ���  /� o   a b�T�T 0 escname escName� m   c d�� ���  :� o   e f�S�S 0 escapp escApp� o      �R�R 0 thelink theLink�X  t ��� l     �Q�P�O�Q  �P  �O  � ��� l     �N�M�L�N  �M  �L  � ��� i   8 ;��� I      �K��J�K 0 
linkitunes 
linkITunes� ��� o      �I�I 0 theprotocol theProtocol� ��H� o      �G�G 0 theapp theApp�H  �J  � k     ��� ��� O     d��� k    c�� ��� r    ��� m    �� ���  i T u n e s :� o      �F�F 0 	thescheme 	theScheme� ��� r    ��� l   ��E�D� n    ��� 1    �C
�C 
pPIS� l   ��B�A� n    � � 4    �@
�@ 
cobj m    �?�?   1    �>
�> 
sele�B  �A  �E  �D  � o      �=�= 0 theid theID�  r     l   �<�; n     1    �:
�: 
pnam l   	�9�8	 n    

 4    �7
�7 
cobj m    �6�6  1    �5
�5 
sele�9  �8  �<  �;   o      �4�4 0 theshortname theShortName  r    % b    # b    ! o    �3�3 0 theshortname theShortName m      �  : o   ! "�2�2 0 theapp theApp o      �1�1 0 thename theName  r   & 0 l  & .�0�/ n   & . 1   , .�.
�. 
pnam l  & ,�-�, n   & ,  4   ) ,�+!
�+ 
cobj! m   * +�*�*   1   & )�)
�) 
sele�-  �,  �0  �/   o      �(�( 0 thetitle theTitle "#" r   1 ;$%$ l  1 9&�'�&& n   1 9'(' 1   7 9�%
�% 
pCmp( l  1 7)�$�#) n   1 7*+* 4   4 7�",
�" 
cobj, m   5 6�!�! + 1   1 4� 
�  
sele�$  �#  �'  �&  % o      �� 0 thecomposer theComposer# -.- r   < F/0/ l  < D1��1 n   < D232 1   B D�
� 
pAlb3 l  < B4��4 n   < B565 4   ? B�7
� 
cobj7 m   @ A�� 6 1   < ?�
� 
sele�  �  �  �  0 o      �� 0 thealbum theAlbum. 898 r   G Q:;: l  G O<��< n   G O=>= 1   M O�
� 
pArt> l  G M?��? n   G M@A@ 4   J M�B
� 
cobjB m   K L�� A 1   G J�
� 
sele�  �  �  �  ; o      �� 0 	theartist 	theArtist9 C�C r   R cDED b   R aFGF b   R _HIH b   R ]JKJ b   R [LML b   R YNON b   R WPQP b   R URSR m   R STT �UU  
S o   S T�� 0 thetitle theTitleQ m   U VVV �WW  
O o   W X�
�
 0 thealbum theAlbumM m   Y ZXX �YY  
K o   [ \�	�	 0 thecomposer theComposerI m   ] ^ZZ �[[  
G o   _ `�� 0 	theartist 	theArtistE o      �� 0 
thecontent 
theContent�  � m     \\�                                                                                  hook  alis    :  rushka                     �/�SH+   3��
iTunes.app                                                      6~�Ɓ[�        ����  	                Applications    �/�C      ƁM�     3��  rushka:Applications:iTunes.app   
 i T u n e s . a p p    r u s h k a  Applications/iTunes.app   / ��  � ]^] l  e e����  �  �  ^ _`_ r   e maba I   e k�c�� (0 encodeuricomponent encodeURIComponentc d�d o   f g� �  0 	thescheme 	theScheme�  �  b o      ���� 0 	escscheme 	escScheme` efe r   n vghg I   n t��i���� (0 encodeuricomponent encodeURIComponenti j��j o   o p���� 0 theshortname theShortName��  ��  h o      ���� 0 escshortname escShortNamef klk r   w mnm I   w }��o���� (0 encodeuricomponent encodeURIComponento p��p o   x y���� 0 thename theName��  ��  n o      ���� 0 escname escNamel qrq r   � �sts I   � ���u���� (0 encodeuricomponent encodeURIComponentu v��v o   � ����� 0 thetitle theTitle��  ��  t o      ���� 0 esctitle escTitler wxw r   � �yzy I   � ���{���� (0 encodeuricomponent encodeURIComponent{ |��| o   � ����� 0 thecomposer theComposer��  ��  z o      ���� 0 esccomposer escComposerx }~} r   � �� I   � �������� (0 encodeuricomponent encodeURIComponent� ���� o   � ����� 0 thealbum theAlbum��  ��  � o      ���� 0 escalbum escAlbum~ ��� r   � ���� I   � �������� (0 encodeuricomponent encodeURIComponent� ���� o   � ����� 0 	theartist 	theArtist��  ��  � o      ���� 0 	escartist 	escArtist� ��� r   � ���� I   � �������� (0 encodeuricomponent encodeURIComponent� ���� o   � ����� 0 
thecontent 
theContent��  ��  � o      ���� 0 
esccontent 
escContent� ���� r   � ���� b   � ���� b   � ���� b   � ���� b   � ���� b   � ���� b   � ���� b   � ���� b   � ���� b   � ���� b   � ���� o   � ����� 0 theprotocol theProtocol� o   � ����� 0 	escscheme 	escScheme� o   � ����� 0 theid theID� m   � ��� ���  /� o   � ����� 0 escname escName� m   � ��� ���  /� o   � ����� 0 escshortname escShortName� m   � ��� ���  /� o   � ����� 0 
esccontent 
escContent� m   � ��� ���  :� o   � ����� 0 escapp escApp� o      ���� 0 thelink theLink��  � ��� l     ��������  ��  ��  � ��� i   < ?��� I      ������� 0 linkterminal linkTerminal� ��� o      ���� 0 theprotocol theProtocol� ���� o      ���� 0 theapp theApp��  ��  � k     e�� ��� O     )��� k    (�� ��� O    ��� r    ��� n    ��� 1    ��
�� 
pcnt� 1    ��
�� 
tcnt� o      ���� 0 
thecontent 
theContent� 4   ���
�� 
cwin� m    ���� � ��� r    ��� m    �� ���  f i l e : /� o      ���� 0 	thescheme 	theScheme� ��� r     ��� l   ������ n    ��� 1    ��
�� 
pnam� 4   ���
�� 
cwin� m    ���� ��  ��  � o      ���� 0 theshortname theShortName� ���� r   ! (��� b   ! &��� b   ! $��� o   ! "���� 0 theshortname theShortName� m   " #�� ���  :� o   $ %���� 0 theapp theApp� o      ���� 0 thename theName��  � m     ���                                                                                      @ alis    X  rushka                     �/�SH+   3��Terminal.app                                                    4(��wU�        ����  	                	Utilities     �/�C      �wG�     3�� 3��  *rushka:Applications:Utilities:Terminal.app    T e r m i n a l . a p p    r u s h k a  #Applications/Utilities/Terminal.app   / ��  � ��� l  * *��������  ��  ��  � ��� r   * 2��� I   * 0������� (0 encodeuricomponent encodeURIComponent� ���� o   + ,���� 0 	thescheme 	theScheme��  ��  � o      ���� 0 	escscheme 	escScheme� ��� r   3 ;��� I   3 9������� (0 encodeuricomponent encodeURIComponent� ���� o   4 5���� 0 theshortname theShortName��  ��  � o      ���� 0 escshortname escShortName� ��� r   < D��� I   < B������� (0 encodeuricomponent encodeURIComponent� ���� o   = >���� 0 thename theName��  ��  � o      ���� 0 escname escName� ��� r   E M��� I   E K������� (0 encodeuricomponent encodeURIComponent� ���� o   F G���� 0 
thecontent 
theContent��  ��  � o      ���� 0 
esccontent 
escContent� ��� l  N N��������  ��  ��  � ���� r   N e��� b   N c��� b   N a	 		  b   N _			 b   N ]			 b   N [			 b   N Y				 b   N W	
		
 b   N U			 b   N S			 b   N Q			 o   N O���� 0 theprotocol theProtocol	 o   O P���� 0 	escscheme 	escScheme	 o   Q R���� 0 escerrorurl escErrorURL	 m   S T		 �		  /	 o   U V���� 0 escname escName		 m   W X		 �		  /	 o   Y Z���� 0 escshortname escShortName	 m   [ \		 �		  /	 o   ] ^���� 0 
esccontent 
escContent	 m   _ `		 �		  :� o   a b���� 0 escapp escApp� o      ���� 0 thelink theLink��  � 			 l     ��������  ��  ��  	 			 i   @ C			 I      ��	 ���� 0 
linkfinder 
linkFinder	  	!	"	! o      ���� 0 theprotocol theProtocol	" 	#��	# o      ���� 0 theapp theApp��  ��  	 k     `	$	$ 	%	&	% O     (	'	(	' k    '	)	) 	*	+	* r    	,	-	, m    	.	. �	/	/  f i l e : /	- o      ���� 0 	thescheme 	theScheme	+ 	0	1	0 r    	2	3	2 c    	4	5	4 1    ��
�� 
sele	5 m    ��
�� 
alis	3 o      ���� 0 theitem theItem	1 	6	7	6 r    	8	9	8 n    	:	;	: 1    ��
�� 
psxp	; o    ���� 0 theitem theItem	9 o      ���� 0 thepath thePath	7 	<	=	< r    	>	?	> l   	@����	@ n    	A	B	A 1    ��
�� 
pnam	B l   	C����	C e    	D	D I   ��	E��
�� .sysonfo4asfe        file	E o    ���� 0 theitem theItem��  ��  ��  ��  ��  	? o      ���� 0 theshorttitle theShortTitle	= 	F�	F r     '	G	H	G b     %	I	J	I b     #	K	L	K o     !�~�~ 0 theshorttitle theShortTitle	L m   ! "	M	M �	N	N  :	J o   # $�}�} 0 theapp theApp	H o      �|�| 0 thetitle theTitle�  	( m     	O	O�                                                                                  MACS  alis    `  rushka                     �/�SH+   3��
Finder.app                                                      4\/ƘY�        ����  	                CoreServices    �/�C      ƘK�     3�� 3І 3Ѕ  -rushka:System:Library:CoreServices:Finder.app    
 F i n d e r . a p p    r u s h k a  &System/Library/CoreServices/Finder.app  / ��  	& 	P	Q	P l  ) )�{�z�y�{  �z  �y  	Q 	R	S	R r   ) 1	T	U	T I   ) /�x	V�w�x (0 encodeuricomponent encodeURIComponent	V 	W�v	W o   * +�u�u 0 	thescheme 	theScheme�v  �w  	U o      �t�t 0 	escscheme 	escScheme	S 	X	Y	X r   2 :	Z	[	Z I   2 8�s	\�r�s (0 encodeuricomponent encodeURIComponent	\ 	]�q	] o   3 4�p�p 0 thepath thePath�q  �r  	[ o      �o�o 0 escpath escPath	Y 	^	_	^ r   ; C	`	a	` I   ; A�n	b�m�n (0 encodeuricomponent encodeURIComponent	b 	c�l	c o   < =�k�k 0 theshorttitle theShortTitle�l  �m  	a o      �j�j 0 escshorttitle escShortTitle	_ 	d	e	d r   D L	f	g	f I   D J�i	h�h�i (0 encodeuricomponent encodeURIComponent	h 	i�g	i o   E F�f�f 0 thetitle theTitle�g  �h  	g o      �e�e 0 esctitle escTitle	e 	j	k	j l  M M�d�c�b�d  �c  �b  	k 	l�a	l r   M `	m	n	m b   M ^	o	p	o b   M \	q	r	q b   M Z	s	t	s b   M X	u	v	u b   M V	w	x	w b   M T	y	z	y b   M R	{	|	{ b   M P	}	~	} o   M N�`�` 0 theprotocol theProtocol	~ o   N O�_�_ 0 	escscheme 	escScheme	| o   P Q�^�^ 0 escpath escPath	z m   R S		 �	�	�  /	x o   T U�]�] 0 esctitle escTitle	v m   V W	�	� �	�	�  /	t o   X Y�\�\ 0 escshorttitle escShortTitle	r m   Z [	�	� �	�	�  :	p o   \ ]�[�[ 0 escapp escApp	n o      �Z�Z 0 thelink theLink�a  	 	�	�	� l     �Y�X�W�Y  �X  �W  	� 	��V	� i   D G	�	�	� I      �U	��T�U "0 linkapplication linkApplication	� 	�	�	� o      �S�S 0 theprotocol theProtocol	� 	��R	� o      �Q�Q 0 theapp theApp�R  �T  	� k     �	�	� 	�	�	� O     F	�	�	� k   	 E	�	� 	�	�	� r   	 	�	�	� m   	 
	�	� �	�	�  f i l e : /	� o      �P�P 0 	thescheme 	theScheme	� 	�	�	� r    	�	�	� m    �O
�O boovfals	� o      �N�N  0 appunsupported appUnsupported	� 	�	�	� Q    %	�	�	�	� r    	�	�	� 4   �M	�
�M 
docu	� m    �L�L 	� o      �K�K 0 thedoc theDoc	� R      �J�I�H
�J .ascrerr ****      � ****�I  �H  	� r   " %	�	�	� m   " #�G
�G boovtrue	� o      �F�F  0 appunsupported appUnsupported	� 	��E	� Z   & E	�	��D�C	� =  & )	�	�	� o   & '�B�B  0 appunsupported appUnsupported	� m   ' (�A
�A boovfals	� k   , A	�	� 	�	�	� r   , 1	�	�	� l  , /	��@�?	� n   , /	�	�	� 1   - /�>
�> 
pnam	� o   , -�=�= 0 thedoc theDoc�@  �?  	� o      �<�< 0 theshorttitle theShortTitle	� 	�	�	� r   2 9	�	�	� b   2 7	�	�	� b   2 5	�	�	� o   2 3�;�; 0 theshorttitle theShortTitle	� m   3 4	�	� �	�	�  :	� o   5 6�:�: 0 theapp theApp	� o      �9�9 0 thetitle theTitle	� 	�	�	� r   : ?	�	�	� n   : =	�	�	� 1   ; =�8
�8 
ppth	� o   : ;�7�7 0 thedoc theDoc	� o      �6�6 0 thepath thePath	� 	��5	� l  @ @�4�3�2�4  �3  �2  �5  �D  �C  �E  	� 4     �1	�
�1 
capp	� l   	��0�/	� c    	�	�	� o    �.�. 0 theapp theApp	� m    �-
�- 
TEXT�0  �/  	� 	�	�	� l  G G�,�+�*�,  �+  �*  	� 	�	�	� r   G O	�	�	� I   G M�)	��(�) (0 encodeuricomponent encodeURIComponent	� 	��'	� o   H I�&�& 0 	thescheme 	theScheme�'  �(  	� o      �%�% 0 	escscheme 	escScheme	� 	��$	� Z   P �	�	��#	�	� =  P S	�	�	� o   P Q�"�"  0 appunsupported appUnsupported	� m   Q R�!
�! boovtrue	� r   V e	�	�	� b   V c	�	�	� b   V a	�	�	� b   V _	�	�	� b   V ]	�	�	� b   V [	�	�	� b   V Y	�	�	� o   V W� �  0 theprotocol theProtocol	� o   W X�� 0 	escscheme 	escScheme	� o   Y Z�� 0 escerrorurl escErrorURL	� m   [ \	�	� �	�	�  /	� o   ] ^�� "0 escerrormessage escErrorMessage	� m   _ `	�	� �	�	�  :	� o   a b�� 0 escapp escApp	� o      �� 0 thelink theLink�#  	� k   h �	�	� 	�	�	� r   h p	�	�	� I   h n�	��� (0 encodeuricomponent encodeURIComponent	� 	��	� o   i j�� 0 thepath thePath�  �  	� o      �� 0 escpath escPath	� 	�	�	� r   q y	�	�	� I   q w�	��� (0 encodeuricomponent encodeURIComponent	� 	��	� o   r s�� 0 theshorttitle theShortTitle�  �  	� o      �� 0 escshorttitle escShortTitle	� 	�	�	� r   z �	�	�	� I   z ��	��� (0 encodeuricomponent encodeURIComponent	� 	��	� o   { |�� 0 thetitle theTitle�  �  	� o      �� 0 esctitle escTitle	� 	��	� r   � �	�	�	� b   � �
 

  b   � �


 b   � �


 b   � �


 b   � �

	
 b   � �




 o   � ��
�
 0 theprotocol theProtocol
 o   � ��	�	 0 	escscheme 	escScheme
	 o   � ��� 0 escpath escPath
 m   � �

 �

  /
 o   � ��� 0 esctitle escTitle
 m   � �

 �

  /
 o   � ��� 0 escshorttitle escShortTitle	� o      �� 0 thelink theLink�  �$  �V       �
















 
!
"�  
 ���� ����������������������������� "0 getitemmetadata getItemMetadata� (0 encodeuricomponent encodeURIComponent� 0 	linkerror 	linkError�  0 
linksafari 
linkSafari��  0 linksafaritabs linkSafariTabs�� 0 linkfirefox linkFirefox�� 0 
linkchrome 
linkChrome�� 0 linkskim linkSkim�� 0 linkbibdesk linkBibDesk�� 0 	linkpages 	linkPages�� 0 linknumbers linkNumbers�� 0 linkkeynote linkKeynote�� 0 linkmail linkMail�� "0 linkaddressbook linkAddressBook�� 0 
linkitunes 
linkITunes�� 0 linkterminal linkTerminal�� 0 
linkfinder 
linkFinder�� "0 linkapplication linkApplication
 �� ����
#
$���� "0 getitemmetadata getItemMetadata�� ��
%�� 
%  ������ 0 theprotocol theProtocol�� 0 theapp theApp��  
# ������ 0 theprotocol theProtocol�� 0 theapp theApp
$ !�� .�� @�� N�� \�� j�� x�� ��� ��� ��� ��� ��� ��� ��� ��� �������
�� 
TEXT�� 0 	linkerror 	linkError�� 0 
linksafari 
linkSafari��  0 linksafaritabs linkSafariTabs�� 0 linkfirefox linkFirefox�� 0 
linkchrome 
linkChrome�� 0 linkskim linkSkim�� 0 linkbibdesk linkBibDesk�� 0 	linkpages 	linkPages�� 0 linknumbers linkNumbers�� 0 linkkeynote linkKeynote�� 0 linkmail linkMail�� "0 linkaddressbook linkAddressBook�� 0 
linkitunes 
linkITunes�� 0 linkterminal linkTerminal�� 0 
linkfinder 
linkFinder�� "0 linkapplication linkApplication�� 0 thelink theLink��-��&� *��l+ Y hO��&�  *��l+ Y��&�  *��l+ Y ��&�  *��l+ Y ݡ�&�  *��l+ 
Y ˡ�&�  *��l+ Y ���&�  *��l+ Y ���&�  *��l+ Y ���&a   *��l+ Y ���&a   *��l+ Y m��&a   *��l+ Y Y��&a   *��l+ Y E��&a   *��l+ Y 1��&a   *��l+ Y ��&a   *��l+ Y 	*��l+ O_  OP
 ������
&
'���� (0 encodeuricomponent encodeURIComponent�� ��
(�� 
(  ���� 0 theuri theURI��  
& ������ 0 theuri theURI�� 0 escuri escURI
' ����!������ 0 	escapelib 	escapeLib
�� 
psxp
�� 
strq
�� .sysoexecTEXT���     TEXT�� ���,%�%��,%j E�
 ��3����
)
*���� 0 	linkerror 	linkError�� ��
+�� 
+  ������ 0 theprotocol theProtocol�� 0 theapp theApp��  
) ���������� 0 theprotocol theProtocol�� 0 theapp theApp�� 0 theerrorurl theErrorURL�� "0 theerrormessage theErrorMessage
* ������H��������
�� 
capp
�� .earsffdralis        afdr
�� 
psxp�� (0 encodeuricomponent encodeURIComponent�� 0 escerrorurl escErrorURL�� "0 escerrormessage escErrorMessage�� 0 escapp escApp�� .*�/j �,E�O��%E�O*�k+ E�O*�k+ E�O*�k+ E�
 ��`����
,
-���� 0 
linksafari 
linkSafari�� ��
.�� 
.  ������ 0 theprotocol theProtocol�� 0 theapp theApp��  
, 
���������������������� 0 theprotocol theProtocol�� 0 theapp theApp�� 0 theurl theURL�� 0 theshorttitle theShortTitle�� 0 thetitle theTitle�� 0 
thecontent 
theContent�� 0 escurl escURL�� 0 escshorttitle escShortTitle�� 0 esctitle escTitle�� 0 
esccontent 
escContent
- �q������|������������
�� 
dcnm
�� 
docu
�� .sfridojs****       utxt�� (0 encodeuricomponent encodeURIComponent�� 0 escapp escApp�� 0 thelink theLink�� n� 0��*�k/l E�O��*�k/l E�O��%�%E�O��*�k/l E�UO*�k+ E�O*�k+ E�O*�k+ E�O*�k+ E�O��%�%�%�%�%�%�%�%�%E�
 �������
/
0����  0 linksafaritabs linkSafariTabs�� ��
1�� 
1  ������ 0 theprotocol theProtocol�� 0 theapp theApp��  
/ 
���������������������� 0 theprotocol theProtocol�� 0 theapp theApp�� 0 thetabs theTabs�� 0 thelinklist theLinkList�� 0 eachtab eachTab�� 0 theurl theURL�� 0 thetitle theTitle�� 0 escurl escURL�� 0 esctitle escTitle�� 0 eachlink eachLink
0 '������������������ ��
�� 
cwin
�� 
bTab
�� 
kocl
�� 
cobj
�� .corecnte****       ****
�� 
dcnm
�� .sfridojs****       utxt�� (0 encodeuricomponent encodeURIComponent�� 0 thelink theLink�� e� [*�k/�-E�OjvE�O J�[��l kh ��l E�O��l E�O)�k+ 
E�O)�k+ 
E�O��%�%�%�%E�O��6G[OY��UO��%E�
 ��4����
2
3���� 0 linkfirefox linkFirefox�� ��
4�� 
4  ������ 0 theprotocol theProtocol�� 0 theapp theApp��  
2 ����~�}�|�{�z�y�x�w�v�� 0 theprotocol theProtocol� 0 theapp theApp�~ 0 oldclipboard oldClipboard�} 0 theurl theURL�| 0 theshorttitle theShortTitle�{ 0 thetitle theTitle�z 0 
thecontent 
theContent�y 0 escurl escURL�x 0 escshorttitle escShortTitle�w 0 esctitle escTitle�v 0 
esccontent 
escContent
3 w�u�tWN�s�r�qT[�p�o�n�mr�l�����k
�u .miscactvnull��� ��� null
�t .JonsgClp****    ��� null
�s 
faal
�r eMdsKcmd
�q .prcskprsnull���    utxt
�p .sysodelanull��� ��� nmbr
�o .JonspClpnull���     ****
�n 
cwin
�m 
pnam�l (0 encodeuricomponent encodeURIComponent�k 0 thelink theLink�� �� P*j O*j E�O� ���l O���l UO�j 
O*j E�O�j O*�k/�,EE�O��%E�O*j E�UO*�k+ E�O*�k+ E�O*�k+ E�O*�k+ E�O��%a %�%a %�%a %�%a %E` 
 �j��i�h
5
6�g�j 0 
linkchrome 
linkChrome�i �f
7�f 
7  �e�d�e 0 theprotocol theProtocol�d 0 theapp theApp�h  
5 �c�b�a�`�_�^�]�\�[�Z�Y�c 0 theprotocol theProtocol�b 0 theapp theApp�a 0 oldclipboard oldClipboard�` 0 theurl theURL�_ 0 theshorttitle theShortTitle�^ 0 thetitle theTitle�] 0 
thecontent 
theContent�\ 0 escurl escURL�[ 0 escshorttitle escShortTitle�Z 0 esctitle escTitle�Y 0 
esccontent 
escContent
6 �X����W�V�U���T�S�R�Q��P)+-/�O�N
�X .JonsgClp****    ��� null
�W 
faal
�V eMdsKcmd
�U .prcskprsnull���    utxt
�T .sysodelanull��� ��� nmbr
�S .JonspClpnull���     ****
�R 
cwin
�Q 
pnam�P (0 encodeuricomponent encodeURIComponent�O 0 escapp escApp�N 0 thelink theLink�g �*j  E�O� D� ���l O���l UO�j 	O*j  E�O�j 
O*�k/�,EE�O��%�%E�O*j  E�UO*�k+ E�O*�k+ E�O*�k+ E�O*�k+ E�O��%�%�%a %�%a %�%a %_ %E` 
 �M8�L�K
8
9�J�M 0 linkskim linkSkim�L �I
:�I 
:  �H�G�H 0 theprotocol theProtocol�G 0 theapp theApp�K  
8 �F�E�D�C�B�A�@�?�>�=�<�;�:�9�8�F 0 theprotocol theProtocol�E 0 theapp theApp�D 0 	thescheme 	theScheme�C 0 thedoc theDoc�B 0 theshorttitle theShortTitle�A 0 thetitle theTitle�@ 0 thepath thePath�? 0 theselection theSelection�> 0 
thecontent 
theContent�= 0 thepage thePage�< 0 	escscheme 	escScheme�; 0 escshorttitle escShortTitle�: 0 esctitle escTitle�9 0 escpath escPath�8 0 
esccontent 
escContent
9 �G�7�6]�5h�4�3�2�1��0�/�.�����-�,
�7 
docu
�6 
pnam
�5 
ppth
�4 
sele
�3 .SKIMTextnull���     ****
�2 
pcnt
�1 
msng
�0 
CPag
�/ .SKIMIndxnull���     ****�. (0 encodeuricomponent encodeURIComponent�- 0 escapp escApp�, 0 thelink theLink�J �� J�E�O*�k/E�O��,E�O��%�%E�O��,�%E�O��,E�O�j �,E�O��  �E�Y hO��,j E�UO*�k+ E�O*�k+ E�O*�k+ E�O*�k+ E�O*�k+ E�O��%�%�%�%�%a %�%a %�%a %_ %E` 
 �+��*�)
;
<�(�+ 0 linkbibdesk linkBibDesk�* �'
=�' 
=  �&�%�& 0 theprotocol theProtocol�% 0 theapp theApp�)  
; �$�#�"�!� �������������������$ 0 theprotocol theProtocol�# 0 theapp theApp�" 0 templatetext templateText�! 0 	thescheme 	theScheme�  0 thedoc theDoc� 0 thetitle theTitle� 0 thepath thePath� 0 theselection theSelection� 0 thepub thePub� 0 thereference theReference� 0 thecite theCite� 0 
theappname 
theAppName� 0 thekeywords theKeywords� 0 	escscheme 	escScheme� 0 esctitle escTitle� 0 esccite escCite� 0 escpath escPath� 0 escreference escReference� 0 
escappname 
escAppName�  0 thekeywordssed theKeywordsSed� 0 theproperty theProperty� 0 
thecontent 
theContent� 0 
esccontent 
escContent
< .�������
�	�����'��ac�oq{����� ��
� 
docu
� 
pnam
� 
ppth
�
 
sele
�	 
cobj
� 
usTx
� 
for � 
� .BDSKttxtnull���     docu
� 
ckey
� 
keyw� (0 encodeuricomponent encodeURIComponent
� .sysoexecTEXT���     TEXT�  0 escapp escApp�� 0 thelink theLink�( �� M�E�O�E�O*�k/E�O��,�%E�O��,�%E�O��,E�O��k/E�O���� E�O��,E�O�%E�O�a ,E�UO*�k+ E�O*�k+ E�O*�k+ E�O*�k+ E^ O*�k+ E^ O*�k+ E^ Oa �%a %j E^ Oa ] %a %E^ O] a %�%E^ O*] k+ E^ O��%] %�%a %�%�%] %a %�%a %] %a %_ %E` 
 �������
>
?���� 0 	linkpages 	linkPages�� ��
@�� 
@  ������ 0 theprotocol theProtocol�� 0 theapp theApp��  
> ������������������������������ 0 theprotocol theProtocol�� 0 theapp theApp�� 0 	thescheme 	theScheme�� 0 thedoc theDoc�� 0 theshorttitle theShortTitle�� 0 thetitle theTitle�� 0 thepath thePath�� 0 
thecontent 
theContent�� 0 
thecharoff 
theCharOff�� 0 	escscheme 	escScheme�� 0 escshorttitle escShortTitle�� 0 esctitle escTitle�� 0 escpath escPath�� 0 
esccontent 
escContent
? ������������������-/13����
�� 
docu
�� 
pnam
�� 
ppth
�� 
pSel
�� 
ofse�� (0 encodeuricomponent encodeURIComponent
�� 
ctxt�� 0 escapp escApp�� 0 thelink theLink�� }� .�E�O*�k/E�O��,E�O��%�%E�O��,�%E�O��,E�O��,E�UO*�k+ 	E�O*�k+ 	E�O*�k+ 	E�O*�k+ 	E�O*��&k+ 	E�O��%�%�%�%�%�%�%�%�%�%�%E` 
 ��:����
A
B���� 0 linknumbers linkNumbers�� ��
C�� 
C  ������ 0 theprotocol theProtocol�� 0 theapp theApp��  
A ���������������������������������������������� 0 theprotocol theProtocol�� 0 theapp theApp�� 0 	thescheme 	theScheme�� 0 thedoc theDoc�� 0 theshorttitle theShortTitle�� 0 thetitle theTitle�� 0 thepath thePath�� 0 thesheet theSheet�� 0 i  �� 0 x  �� 0 thetable theTable�� 0 therange theRange�� 0 
thecontent 
theContent��  0 therangevalues theRangeValues�� 0 	escscheme 	escScheme�� 0 escshorttitle escShortTitle�� 0 esctitle escTitle�� 0 escpath escPath�� 0 escsheet escSheet�� 0 esctable escTable�� 0 escrange escRange�� 0 
esccontent 
escContent
B "I����_��j������
D��������������������������TVXZ����
�� 
docu
�� 
pnam
�� 
ppth
�� 
NmSh
�� .corecnte****       ****
�� 
NmTb
D  
�� 
NMTs
�� 
msng
�� 
ctxt
�� 
NmCl
�� 
NMCv
�� 
ascr
�� 
txdl
�� 
TEXT�� (0 encodeuricomponent encodeURIComponent�� 0 escapp escApp�� 0 thelink theLink���� ��E�O*�k/E�O��,E�O��%�%E�O��,�%E�O� �jE�O >k*�-j kh *�/ *�-�[�,\Z�91j E�UO�j 
�E�OY h[OY��O�j  k�%E�Ok�%E�O�E�Oa E�Y j*�/ b*�k/�[�,\Z�91E�O� M�a &a %E�O��,a %E�O*�,�,E�O*�,a -a ,E�Oa _ a ,FO�a &E�Oa _ a ,FUUUUO*�k+ E�O*�k+ E�O*�k+ E^ O*�k+ E^ O*�k+ E^ O*�k+ E^ O*�k+ E^ O*�k+ E^ O��%] %] %] %] %a %] %a %�%a %] %a %_  %E` !
 ��a����
E
F���� 0 linkkeynote linkKeynote�� ��
G�� 
G  ������ 0 theprotocol theProtocol�� 0 theapp theApp��  
E �������������������������������� 0 theprotocol theProtocol�� 0 theapp theApp�� 0 	thescheme 	theScheme�� 0 thedoc theDoc�� 0 theshorttitle theShortTitle�� 0 thetitle theTitle�� 0 thepath thePath�� 0 theslide theSlide�� 0 theslideindex theSlideIndex�� 0 
thecontent 
theContent�� 0 	escscheme 	escScheme�� 0 escpath escPath�� 0 esctitle escTitle�� 0 escshorttitle escShortTitle�� 0 
esccontent 
escContent
F �p���������������������������
�� 
docu
�� 
pnam
�� 
ppth
�� 
KnCS
�� 
KSdN
�� 
titl
�� 
btxt�� (0 encodeuricomponent encodeURIComponent�� 0 escapp escApp�� 0 thelink theLink�� �� ;�E�O*�k/E�O��,E�O��%E�O��,�%E�O*�k/�,E�O��,E�O��,�%��,%E�UO*�k+ E�O*�k+ E�O*�k+ E�O*�k+ E�O*�k+ E�O��%�%�%�%�%�%�%�%�%a %_ %E` OP
 �������
H
I���� 0 linkmail linkMail�� ��
J�� 
J  ������ 0 theprotocol theProtocol�� 0 theapp theApp��  
H ��������������������������~�� 0 theprotocol theProtocol�� 0 theapp theApp�� 0 theselection theSelection�� 0 
themessage 
theMessage�� 0 theid theID�� "0 theshortsubject theShortSubject�� 0 
thesubject 
theSubject�� 0 
thecontent 
theContent�� 0 	thescheme 	theScheme�� 0 escid escID�� "0 escshortsubject escShortSubject�� 0 
escsubject 
escSubject� 0 	escscheme 	escScheme�~ 0 
esccontent 
escContent
I /�}�|�{�z�y�x#�w-�vikmo�u�t
�} 
slct
�| 
kocl
�{ 
cobj
�z .corecnte****       ****
�y 
meid
�x 
subj
�w 
ctnt�v (0 encodeuricomponent encodeURIComponent�u 0 escapp escApp�t 0 thelink theLink�� �� :*�,E�O -�[��l kh ��,E�O��,E�O��%�%E�O��,E�[OY��O�E�UO*�k+ 
E�O*�k+ 
E�O*�k+ 
E�O*�k+ 
E�O*�k+ 
E�O��%�%�%�%�%�%�%�%�%�%E` 
 �sv�r�q
K
L�p�s "0 linkaddressbook linkAddressBook�r �o
M�o 
M  �n�m�n 0 theprotocol theProtocol�m 0 theapp theApp�q  
K 
�l�k�j�i�h�g�f�e�d�c�l 0 theprotocol theProtocol�k 0 theapp theApp�j 0 	thescheme 	theScheme�i 0 allcontacts AllContacts�h 0 one_contact  �g 0 theid theID�f 0 thename theName�e 0 escid escID�d 0 escname escName�c 0 	escscheme 	escScheme
L ���b�a�`�_�^��]��\�[���Z�Y
�b 
az48
�a 
cobj
�` 
nmbr
�_ 
ID  
�^ 
pnam
�] .miscactvnull��� ��� null
�\ .sysodlogaskr        TEXT�[ (0 encodeuricomponent encodeURIComponent�Z 0 escapp escApp�Y 0 thelink theLink�p j� ;�E�O*�,E�O��-�,k  ��k/E�O��,E�O��,E�Y � *j O�j 
UUO*�k+ E�O*�k+ E�O*�k+ E�O��%�%�%�%�%�%E�
 �X��W�V
N
O�U�X 0 
linkitunes 
linkITunes�W �T
P�T 
P  �S�R�S 0 theprotocol theProtocol�R 0 theapp theApp�V  
N �Q�P�O�N�M�L�K�J�I�H�G�F�E�D�C�B�A�@�?�Q 0 theprotocol theProtocol�P 0 theapp theApp�O 0 	thescheme 	theScheme�N 0 theid theID�M 0 theshortname theShortName�L 0 thename theName�K 0 thetitle theTitle�J 0 thecomposer theComposer�I 0 thealbum theAlbum�H 0 	theartist 	theArtist�G 0 
thecontent 
theContent�F 0 	escscheme 	escScheme�E 0 escshortname escShortName�D 0 escname escName�C 0 esctitle escTitle�B 0 esccomposer escComposer�A 0 escalbum escAlbum�@ 0 	escartist 	escArtist�? 0 
esccontent 
escContent
O \��>�=�<�;�:�9�8TVXZ�7�����6�5
�> 
sele
�= 
cobj
�< 
pPIS
�; 
pnam
�: 
pCmp
�9 
pAlb
�8 
pArt�7 (0 encodeuricomponent encodeURIComponent�6 0 escapp escApp�5 0 thelink theLink�U �� a�E�O*�,�k/�,E�O*�,�k/�,E�O��%�%E�O*�,�k/�,E�O*�,�k/�,E�O*�,�k/�,E�O*�,�k/�,E�O�%�%�%�%�%�%�%E�UO*�k+ E�O*�k+ E�O*�k+ E�O*�k+ E�O*�k+ E�O*�k+ E^ O*�k+ E^ O*�k+ E^ O��%�%�%�%a %�%a %] %a %_ %E` 
  �4��3�2
Q
R�1�4 0 linkterminal linkTerminal�3 �0
S�0 
S  �/�.�/ 0 theprotocol theProtocol�. 0 theapp theApp�2  
Q 
�-�,�+�*�)�(�'�&�%�$�- 0 theprotocol theProtocol�, 0 theapp theApp�+ 0 
thecontent 
theContent�* 0 	thescheme 	theScheme�) 0 theshortname theShortName�( 0 thename theName�' 0 	escscheme 	escScheme�& 0 escshortname escShortName�% 0 escname escName�$ 0 
esccontent 
escContent
R ��#�"�!�� ���				��
�# 
cwin
�" 
tcnt
�! 
pcnt
�  
pnam� (0 encodeuricomponent encodeURIComponent� 0 escerrorurl escErrorURL� 0 escapp escApp� 0 thelink theLink�1 f� &*�k/ 	*�,�,E�UO�E�O*�k/�,E�O��%�%E�UO*�k+ E�O*�k+ E�O*�k+ E�O*�k+ E�O��%�%�%�%�%�%�%�%�%�%E�
! �	��
T
U�� 0 
linkfinder 
linkFinder� �
V� 
V  ��� 0 theprotocol theProtocol� 0 theapp theApp�  
T �����������
� 0 theprotocol theProtocol� 0 theapp theApp� 0 	thescheme 	theScheme� 0 theitem theItem� 0 thepath thePath� 0 theshorttitle theShortTitle� 0 thetitle theTitle� 0 	escscheme 	escScheme� 0 escpath escPath� 0 escshorttitle escShortTitle�
 0 esctitle escTitle
U 	O	.�	����	M�		�	���
�	 
sele
� 
alis
� 
psxp
� .sysonfo4asfe        file
� 
pnam� (0 encodeuricomponent encodeURIComponent� 0 escapp escApp� 0 thelink theLink� a� %�E�O*�,�&E�O��,E�O�j �,E�O��%�%E�UO*�k+ E�O*�k+ E�O*�k+ E�O*�k+ E�O��%�%�%�%�%�%�%�%E�
" �	�� ��
W
X��� "0 linkapplication linkApplication�  ��
Y�� 
Y  ������ 0 theprotocol theProtocol�� 0 theapp theApp��  
W �������������������������� 0 theprotocol theProtocol�� 0 theapp theApp�� 0 	thescheme 	theScheme��  0 appunsupported appUnsupported�� 0 thedoc theDoc�� 0 theshorttitle theShortTitle�� 0 thetitle theTitle�� 0 thepath thePath�� 0 	escscheme 	escScheme�� 0 escpath escPath�� 0 escshorttitle escShortTitle�� 0 esctitle escTitle
X ����	���������	�������	���	�����


�� 
capp
�� 
TEXT
�� 
docu��  ��  
�� 
pnam
�� 
ppth�� (0 encodeuricomponent encodeURIComponent�� 0 escerrorurl escErrorURL�� "0 escerrormessage escErrorMessage�� 0 escapp escApp�� 0 thelink theLink�� �*��&/ >�E�OfE�O *�k/E�W 
X  eE�O�f  ��,E�O��%�%E�O��,E�OPY hUO*�k+ 	E�O�e  ��%�%�%�%�%�%E�Y 0*�k+ 	E�O*�k+ 	E�O*�k+ 	E�O��%�%a %�%a %�%E�ascr  ��ޭ