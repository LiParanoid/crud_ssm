package com.rytong.crud.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.rytong.crud.bean.Employee;
import com.rytong.crud.bean.Msg;
import com.rytong.crud.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author Paranoid
 * @create 2018-12-01 15:37
 * <p>
 * 处理员工CRUD请求
 */
@Controller
public class EmployeeController {
    @Autowired
    EmployeeService employeeService;

    /**
     * 通过改造后成为一个可以实现单个删除和批量删除的方法
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{ids}", method = RequestMethod.DELETE)
    public Msg deleteEmp(@PathVariable("ids") String ids) {
        if (ids.contains("-")) {
            String[] ids_str = ids.split("-");
            employeeService.deleteBatch(ids_str);
            return Msg.success();
        } else {
            int id = Integer.parseInt(ids);
            employeeService.deleteEmp(id);
            return Msg.success();
        }
    }

    /**
     * 员工更新方法
     *
     * @param employee
     * @return
     */
    @RequestMapping(value = "/emp/{empId}", method = RequestMethod.PUT)
    @ResponseBody
    public Msg saveEmp(Employee employee) {
        employeeService.updateEmp(employee);
        return Msg.success();
    }

    /**
     * 按照员工id查询
     *
     * @param id
     * @return
     */
    @RequestMapping(value = "/emp/{id}", method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("id") Integer id) {
        Employee emp = employeeService.getEmp(id);
        return Msg.success().add("emp", emp);
    }

    /**
     * @param empName
     * @return
     */
    @ResponseBody
    @RequestMapping("/checkEmpName")
    public Msg checkEmpName(@RequestParam("empName") String empName) {
        String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
        boolean math = empName.matches(regx);
        if (!math) {
            return Msg.fail().add("msg_vl", "用户名可以是2-5位的中文或者6-16位的大小写英文字母和'_'、'-'的组合");
        }
        Boolean b = employeeService.checkEmpName(empName);
        if (b) {
            return Msg.success();
        } else {
            return Msg.fail().add("msg_vl", "用户名已存在");
        }
    }

    /**
     * 员工保存
     *
     * @return
     */
    @RequestMapping(value = "/emps", method = RequestMethod.POST)
    @ResponseBody
    public Msg saveMsg(@Valid Employee employee, BindingResult result) {
        if (result.hasErrors()) {
            Map<String, Object> messageMap = new HashMap<String, Object>();
            List<FieldError> fieldErrors = result.getFieldErrors();
            for (FieldError fieldError : fieldErrors) {
                //错误的字段名
                String errorField = fieldError.getField();
                String errorDefaultMessage = fieldError.getDefaultMessage();
                messageMap.put(errorField, errorDefaultMessage);
            }
            return Msg.fail().add("errorFieldMap", messageMap);
        } else {
            employeeService.saveEmp(employee);
            return Msg.success();
        }
    }

    /**
     * 需要导入Jackson包
     *
     * @param pn
     * @return
     */
    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
        // 会查出所有 不是一个分页查询
        //引入PageHelper插件
        // 在查询之前只需要调用
        PageHelper.startPage(pn, 5);
        // startPage后面紧跟的这个查询就是一个分页查询
        List<Employee> emps = employeeService.getAll();
        // 使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就行了。
        // 封装了详细的分页信息,包括有我们查询出来的数据，传入连续显示的页数
        PageInfo page = new PageInfo(emps, 5);

        return Msg.success().add("pageInfo", page);
    }

    /**
     * 查询员工数据
     *
     * @return
     */
    //@RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {
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
