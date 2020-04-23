# Bkey

> Key-binding that SuperB

## About

Đây là tài liệu cho tư tương (mind-set) key-binding Bkey. đây là design guidelines, detailed technical views of Bkey.

Tài liệu này được lấy cảm hứng từ [Blog của Xah về bàn phím](http://xahlee.info/kbd/keyboarding.html)

### Story

Sau khi thiết kế Blayout, tôi cuốn theo [Blog của Xah về bàn phím](http://xahlee.info/kbd/keyboarding.html) và tìm đến Emacs và rồi cả [Ergoemacs](https://ergoemacs.github.io/). Nhưng cả hai cái tôi đêề thấy có nhiều điều không hợp lí, mà có lẽ bản thân Emacs và tôi không hợp nhau, cháu này thì được cái tùy chỉnh tùy biến nhiều mê li nhưng có nhiều cái lại không thể thay đổi được ...

Một thời gian sau tôi tìm đến Vim và thấy rằng Vim out-of-the-box đã có nhiều cái tiện lợi hơn Emacs mà lại còn ií cồng kềnh, tôi ngay lập tức mang cái thiết kế key-binding nửa mùa bên Emacs sang bên này và hoàn thiện nốt.

### Features

  * Dễ làm quen với nhiều key-binding đã xuất hiện ở các phần mềm nổi tiếng:
    * Tất cả các nút <kbd>MŨI-TÊN</kbd>, <kbd>SPACE</kbd>, <kbd>ENTER</kbd>, <kbd>BS</kbd>, <kbd>DEL</kbd>, <kbd>ESC</kbd>, <kbd>TAB</kbd>... hành xử quen thuộc
    * Các nút <kbd>Ctrl</kbd> + <kbd>z</kbd>,<kbd>x</kbd>,<kbd>c</kbd>,<kbd>v</kbd> để Undo, Cut, Copy, Paste. Tương tự với các nút bắt đầu với <kbd>Ctrl</kbd> khác
  * Giúp người dùng thoải:
    * Giúp người dùng tránh phải sử dụng các nút ngón út và ngón nhẫn:
      * [Đánh giá các ngón]()
    * Ngón trỏ luôn đặt đúng vị trí trên bàn phím thuận lợi cho việc đánh máy mà phông cần phải chuyển lệch:
      * [WASD hay ESDF]()
      * [HJKL hay IJKL]()
  * Thậm chí còn tương thích được với việc chơi game

## Contents

  * [About](#about)
    * [Story](#story)
    * [Features](#features)
  * [Contents](#contents)
  * [References](#references)
    * [Operation](#operation)
    * [Movements](#movements)
    * [Actions](#actions)
    * [Application](#application)
    * [Views](#views)
  * [Vim](#vim)
  * [TODO/FIXME]()

## References

### Operation

![](image/operation.png)

  * Hold keys:
    * Các nút tự bản thân nó không làm gì nhưng khi kết hợp với các nút khác sẽ giúp các nút đó mang ý nghĩa khác:
      * <kbd>Shift</kbd>:
        * Khỏe hơn, nhanh hơn, mang phạm vi lớn hơn (từ điểm bắt đầu đêế cuối dòng, cuối file...).
        * Theo hương ngược lại (ví dụ: Undo thành Redo).
        * nếu phím ban đâu là hành động Load thì khi giữ <kbd>Shift</kbd> sẽ là lưu.
        * Nếu có một hành động nào đấy mà được sử dụng rất nhiều mà các vị trí khác không hợp lí thì hãn hưu lắm mới dùng <kbd>Shift</kbd> sai quy định.
      * <kbd>Ctrl</kbd>:
        * Kiểm soát, kĩ càng, tập trung.
      * <kbd>Alt</kbd>:
        * Nếu ở trong môi trường mà các nút trần đã có nhiệm vụ khác (như trong môi trường viết chữ, các nút trần đã có nhiệm vụ gửi kí tự) thì <kbd>Alt</kbd> Sẽ là nút <kbd>Mod</kbd> nếu không nó sẽ là <kbd>Alt</kbd>.
          * <kbd>Mod</kbd>:
            * Làm hành động.
          * <kbd>Alt</kbd>:
            * Làm theo cách khác, hành động ít được sử dụng hơn.
      * <kbd>Super</kbd>:
        * Ở Windows thì tên là <kbd>Windows</kbd>, trên Linux là <kbd>Super</kbd> còn MacOS là <kbd>Command</kbd>. Đây là nút duy nhất (Không sử dụng <kbd>Alt</kbd> hay <kbd>Ctrl</kbd> + <kbd>Alt</kbd>) để xử lí các hành động mang phạm vi trên hệ điều hành như quan lí cửa sổ, Shortcut để mở úng dụng ...
  * Number keys:
    * Làm hành động mang tên hoọă ở vị trí của số.
    * Dùng để gàn số lần làm một hành động gì đó.

### Movements

![](image/movements/1.png)

  * <kbd>i</kbd>, <kbd>j</kbd>, <kbd>k</kbd>, <kbd>l</kbd>:
    * Các nút để di chuyển cở bản Up, Down, Left, Right.
    * <kbd>i</kbd>, <kbd>k</kbd>:
      * Di chuyển lên/xuống 1 dòng, giữ <kbd>Shift</kbd> để di chuyển theo từng khổ.
    * <kbd>j</kbd>, <kbd>l</kbd>:
      * Di chuyển sang trái/phải 1 kí tự, giữ <kbd>Shift</kbd> để di chuyển theo từng từ.
  * <kbd>u</kbd>, <kbd>o</kbd>:
    * Dựa theo thiết kế của một số loại bàn phím laptop #TODO.
    * Di chuyển sang trái/phải 1 TỪ, giữ <kbd>Shift</kbd> để di chuyển lên/xuống từng trang.
    * Ngó sang trái/phải.
    * Xoay theo chiều ngược/thuận kim đồng hồ.
  * <kbd>m</kbd>:
    * Đi đến vị trí đầu, giữ <kbd>Shift</kbd> để di chuyển đến cuối.
    * #TODO


![](image/movements/2.png)

  * <kbd>g</kbd>:
    * Lấy vị trí <kbd>g</kbd> từ Vim, Chỉ vị trí, di chuyển nhanh đến một vị trí nào đó.
  * <kbd>h</kbd>:
    * Lấy vị trí <kbd>Ctrl + h</kbd> trên các text-editor phổ biến làm hành động tìm kiếm và thay thế trên các phần mềm khác.
    * Bình thường chỉ để tìm kiếm, làm gắt thì vừ tìm vừa thay thế.
  * <kbd>n</kbd>:
    * Lấy vị trí <kbd>n</kbd> từ Vim, tìm tiếp tực và tìm ngược hướng.
