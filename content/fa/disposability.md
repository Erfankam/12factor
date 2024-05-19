## IX. یکبار مصرف
### با راه اندازی سریع و خاموش شدن دلپذیر، استحکام را به حداکثر برسانید

**[فرآیندهای](./فرآیندهای) برنامه دوازده عاملی *یکبار مصرف* هستند، به این معنی که می توان آنها را در یک لحظه شروع یا متوقف کرد.** این کار مقیاس بندی سریع الاستیک، استقرار سریع [کد] (./codebase را تسهیل می کند. ) یا [config](./config) تغییرات، و استحکام توسعه تولید.

فرآیندها باید تلاش کنند **زمان راه اندازی را به حداقل برسانند**. در حالت ایده‌آل، یک فرآیند از زمان اجرای دستور راه‌اندازی چند ثانیه طول می‌کشد تا زمانی که فرآیند آماده شود و درخواست‌ها یا کارها را دریافت کند. زمان راه‌اندازی کوتاه، چابکی بیشتری را برای فرآیند [release](./build-release-run) و افزایش مقیاس فراهم می‌کند. و به استحکام کمک می کند، زیرا مدیر فرآیند در صورت لزوم می تواند به راحتی فرآیندها را به ماشین های فیزیکی جدید منتقل کند.

فرآیندها **هنگامی که سیگنال [SIGTERM](http://en.wikipedia.org/wiki/SIGTERM)** را از مدیر فرآیند دریافت می کنند، به آرامی خاموش می شوند. برای یک فرآیند وب، خاموش شدن دلپذیر با توقف گوش دادن به درگاه سرویس (در نتیجه رد هر درخواست جدید)، اجازه دادن به تمام درخواست‌های فعلی و سپس خروج به دست می‌آید. ضمناً در این مدل این است که درخواست‌های HTTP کوتاه هستند (بیش از چند ثانیه)، یا در مورد نظرسنجی طولانی، کلاینت باید به‌طور یکپارچه تلاش کند تا زمانی که اتصال قطع شد دوباره وصل شود.

برای یک فرآیند کارگری، با برگرداندن کار فعلی به صف کار، خاموشی دلپذیر حاصل می شود. برای مثال، در [RabbitMQ](http://www.rabbitmq.com/) کارگر می تواند یک ['NACK'](http://www.rabbitmq.com/amqp-0-9-1-quickref) ارسال کند. html#basic.nack)؛ در [Beanstalkd](https://beanstalkd.github.io)، هر زمان که یک کارگر ارتباط خود را قطع کند، کار به طور خودکار به صف باز می گردد. سیستم‌های مبتنی بر قفل مانند [Delayed Job](https://github.com/collectiveidea/delayed_job#readme) باید حتماً قفل خود را در سابقه کار آزاد کنند. ضمنی در این مدل این است که همه مشاغل [باز وارد] هستند (http://en.wikipedia.org/wiki/Reentrant_%28subroutine%29)، که معمولاً با بسته بندی نتایج در یک تراکنش، یا انجام عملیات [idempotent] به دست می آید. ](http://en.wikipedia.org/wiki/Idempotence).

فرآیندها همچنین باید **در برابر مرگ ناگهانی** قوی باشند، در صورت خرابی در سخت افزار زیرین. در حالی که این اتفاق بسیار کمتر از یک خاموشی دلپذیر با «SIGTERM» است، اما همچنان ممکن است رخ دهد. یک رویکرد توصیه شده استفاده از یک باطن صف قوی، مانند Beanstalkd است، که در صورت قطع اتصال مشتریان یا اتمام زمان، کارها را به صف باز می گرداند. در هر صورت، یک برنامه دوازده عاملی برای مدیریت خاتمه های غیرمنتظره و غیر دلپذیر طراحی شده است. [طراحی فقط تصادف] (http://lwn.net/Articles/191059/) این مفهوم را به [نتیجه گیری منطقی] خود می برد (http://docs.couchdb.org/en/latest/intro/overview.html) .