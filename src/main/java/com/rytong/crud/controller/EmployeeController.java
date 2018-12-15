package com.rytong.crud.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.rytong.crud.bean.Employee;
import com.rytong.crud.bean.Msg;
import com.rytong.crud.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @author Paranoid
 * @create 2018-12-01 15:37
 *
 * 处理员工CRUD请求
 */
@Controller
public class EmployeeController {
    @Autowired
    EmployeeService employeeService;

    @ResponseBody
    @RequestMapping("/checkEmpName")
    public Msg checkEmpName(@RequestParam("empName") String empName){
        Boolean b = employeeService.checkEmpName(empName);
        if(b){
            return Msg.success();
        }else{
            return Msg.fail();
        }
    }

    /**
     * 员工保存
     * @return
     */
    @RequestMapping(value="/emps",method = RequestMethod.POST)
    @ResponseBody
    public Msg saveMsg(Employee employee){
        employeeService.saveEmp(employee);
        return Msg.success();
    }

    /**
     * 需要导入Jackson包
     * @param pn
     * @return
     */
    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value = "pn",defaultValue = "1")Integer pn){
        // 会查出所有 不是一个分页查询
        //引入PageHelper插件
        // 在查询之前只需要调用
        PageHelper.startPage(pn, 5);
        // startPage后面紧跟的这个查询就是一个分页查询
        List<Employee> emps = employeeService.getAll();
        // 使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就行了。
        // 封装了详细的分页信息,包括有我们查询出来的数据，传入连续显示的页数
        PageInfo page = new PageInfo(emps, 5);

        return Msg.success().add("pageInfo",page);
    }
    /**
     * 查询员工数据
     * @return
     */
    //@RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn",defaultValue = "1")Integer pn, Model model){
        // 会查出所有 不是一个分页查询
        //引入PageHelper插件
        // 在查询之前只需要调用
        PageHelper.startPage(pn, 5);
        // startPage后面紧跟的这个查询就是一个分页查询
        List<Employee> emps = employeeService.getAll();
        // 使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就行了。
        // 封装了详细的分页信息,包括有我们查询出来的数据，传入连续显示的页数
        PageInfo page = new PageInfo(emps, 5);

        model.addAttribute("pageInfo", page);
        return "list";
    }
}
