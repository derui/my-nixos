{
  programs.newsboat = {
    enable = true;

    urls = [
      { url = "https://gigazine.net/news/rss_2.0/"; }
      { url = "https://www.engadget.com/rss.xml"; }
      { url = "http://moguragames.com/feed"; }
      { url = "https://aws.amazon.com/jp/blogs/aws/feed/"; }
      { url = "https://dev.classmethod.jp/feed/"; }
      { url = "https://ascii.jp/rss.xml"; }
      { url = "https://feed.infoq.com"; }
    ];

    extraConfig = ''
      color background         default default
      color listnormal         default default
      color listnormal_unread  color15 default bold
      color listfocus          green   default reverse
      color listfocus_unread   color10 default reverse bold
      color title              cyan    default reverse
      color info               magenta default reverse
      color hint-key           magenta default
      color hint-separator     magenta default
      color article            default default
      color end-of-text-marker color8  default
    '';
  };
}
