Sử dụng @Entity cho class Object liên kết tới bảng
Sử dụng @Id cho biến liên kết với khóa chính của bảng
Sử dụng @OneToOne hoặc @ManyToOne và @JoinColumn(name = "name_columnRef", referencedColumnName = "name_column") cho Object để liên kết với bảng được khóa ngoại của bảng này tham chiếu
Sử dụng @OneToOne(mappedBy = "nameVal") hoặc @OneToMany(mappedBy = "nameVal") cho Object để liên kết Object được khóa ngoại của bảng khác tham chiếu
Sử dụng @ManyToMany và @JoinTable(name = "name_Object", joinColumns = @JoinColumn(name = "name_columnRef"), inverseJoinColumns = @JoinColumn(name = "name_column") để liên kết Object thông qua bảng trung gian\
Lưu ý:
  Măc định @OneToMany và ManyToMany là  fetch=LAZY
